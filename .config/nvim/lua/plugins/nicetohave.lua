return {
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            spec = {
                { '<leader>f', group = '[F]ind'},
                { '<leader>s', group = '[S]earch'},
                { '<leader>g', group = '[G]o to'},
                { '<leader>t', group = '[T]oggle'},
                { '<leader>h', group = '[H]arpoon'},
            }
        },
    },
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false }},
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        -- Optional dependency
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup {}
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },
    {
        'tadachs/ros-nvim',
        config = function() require("ros-nvim").setup(
            {
                only_workspace = true
            }
            )
        end,
        dependencies = {"nvim-lua/plenary.nvim"},
    },
}
