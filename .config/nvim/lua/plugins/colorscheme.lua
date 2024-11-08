return{
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()

        require('tokyonight').setup( {
            style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                keywords = { italic = true },
                functions = {italic=true},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark", -- style for sidebars, see below
                floats = "dark", -- style for floating windows
            },
            on_colors = function(colors)
                colors.border_highlight = colors.orange
                colors.border = colors.orange
                colors.bg_statusline = require('tokyonight.util').lighten(colors.bg_statusline, 0.8)
                colors.bg_float = require('tokyonight.util').lighten(colors.bg, 0.92)
                colors.fg_float = colors.orange
            end,

            on_highlights = function (highlights, colors)
               -- highlights.border_highlight.background = colors.orange
            end,
        }
        )
        vim.cmd.colorscheme 'tokyonight'
    end,

}
