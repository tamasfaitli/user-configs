-- debug.lua
--
-- Current setup is good, not yet great.
-- Ideally my UI would have windows as:
--  - have a watch window with list of variables added
--  - have a list of breakpoints
--  - stack
--  - code
-- Furthermore, session would be stored with all variables added to the watchlist and breakpoints set


return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Persistent breakpoints (not to reset after reopening a vim session)
    'Weissle/persistent-breakpoints.nvim',
    -- Add your own debuggers here
    -- cpp debugger
    'julianolf/nvim-dap-lldb',
    -- python debugger
    'mfussenegger/nvim-dap-python',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    local persbpapi = require 'persistent-breakpoints.api'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F9>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F7>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F6>', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>tb', persbpapi.toggle_breakpoint, desc = 'Debug: [T]oggle [B]reakpoint' },
      { '<leader>B', function()
          persbpapi.set_conditional_breakpoint()
        end, {desc = 'Debug: [B]reakpoint Conditional', silent=true}
      },
      { '<leader>tl', function()
          persbpapi.set_log_point() end, {desc = 'Debug: [T]oggle [L]ogpoint', silent=true}
      },
      -- NOTE: Do it twice, and it jumps into the popup window to expand structs etc..
      {'<leader>E', function()
        dapui.eval()
      end, {desc= 'Debug: [E]val'}},
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F2>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local persbp = require 'persistent-breakpoints'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'debugpy',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '',
          step_over = '',
          step_out = '󰆸',
          step_back = '',
          run_last = '󰑙',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }


    -- persistent breakpoints settings
    persbp.setup{
        save_dir = vim.fn.getcwd() .. '/.nvim_checkpoints',
        -- NOTE: In the docker setup the above one is fine but on a normal system I would not use it
        -- save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',

        load_breakpoint_event = {"BufReadPost"},

        perf_record = false,
        on_load_breakpoint = true,
   }


    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    
    -- Install language specific adapters
    require('dap-lldb').setup()
    require('dap-python').setup("python3")
  end,
}
