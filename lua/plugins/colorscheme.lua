return {
  {
    {
      "xiyaowong/transparent.nvim",
      config = function()
        require("transparent").setup({
          enable = true, -- boolean: enable transparent
          extra_groups = { -- table/string: additional groups that should be cleared
            "Normal",
            "NormalNC",
            "Comment",
            "Constant",
            "Special",
            "Identifier",
            "Statement",
            "PreProc",
            "Type",
            "Underlined",
            "Todo",
            "String",
            "Function",
            "Conditional",
            "Repeat",
            "Operator",
            "Structure",
            "LineNr",
            "NonText",
            "SignColumn",
            "CursorLineNr",
            "EndOfBuffer",
          },
          exclude = {}, -- table: groups you don't want to clear
        })
        vim.cmd("TransparentEnable") -- execute the command to enable transparency
      end,
    },

    { "rktjmp/lush.nvim" },

    "anAcc22/sakura.nvim",
    config = function()
      vim.opt.background = "transparent"
      vim.cmd("colorscheme sakura")
    end,
  },
  -- {
  --   -- Plugin for the Catppuccin color scheme
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false, -- Load this plugin immediately
  --   opts = {
  --     transparent_background = true, -- Enable transparent background
  --     flavour = "mocha", -- Set the flavor of the color scheme
  --   },
  --   integrations = {
  --     cmp = true, -- Enable integration with nvim-cmp
  --     gitsigns = true, -- Enable integration with gitsigns
  --     nvimtree = true, -- Enable integration with nvim-tree
  --     treesitter = true, -- Enable integration with treesitter
  --     notify = false, -- Disable integration with nvim-notify
  --     mini = {
  --       enabled = true, -- Enable mini plugin integration
  --       indentscope_color = "", -- Set indentscope color (empty means default)
  --     },
  --     -- Additional plugin integrations can be found in the documentation
  --   },
  -- },
  -- {
  --   -- Plugin for the Modus Themes
  --   "miikanissi/modus-themes.nvim",
  --   name = "modus",
  --   priority = 1000, -- High priority to ensure it loads early
  -- },
  -- {
  --   -- Plugin for the Kanagawa color scheme
  --   "rebelot/kanagawa.nvim",
  --   name = "kanagawa",
  --   priority = 1000, -- High priority to ensure it loads early
  --   opts = {
  --     transparent = true, -- Enable transparent background
  --     theme = "dragon", -- Set the theme variant to 'dragon'
  --     overrides = function(colors)
  --       local theme = colors.theme
  --       return {
  --         NormalFloat = { bg = "none" }, -- Transparent background for floating windows
  --         FloatBorder = { bg = "none" }, -- Transparent background for floating window borders
  --         FloatTitle = { bg = "none" }, -- Transparent background for floating window titles
  --
  --         NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 }, -- Custom colors for dark mode
  --
  --         LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim }, -- Custom colors for Lazy plugin
  --         MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim }, -- Custom colors for Mason plugin
  --
  --         FzfLuaNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 }, -- Custom colors for FzfLua normal
  --         FzfLuaBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 }, -- Custom colors for FzfLua border
  --         FzfLuaTitle = { fg = theme.ui.special, bold = true }, -- Custom colors for FzfLua title
  --
  --         Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- Custom colors for popup menu
  --         PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 }, -- Custom colors for selected item in popup menu
  --         PmenuSbar = { bg = theme.ui.bg_m1 }, -- Custom colors for popup menu scrollbar
  --         PmenuThumb = { bg = theme.ui.bg_p2 }, -- Custom colors for popup menu thumb
  --       }
  --     end,
  --   },
  -- },
  -- Plugin for the Oxocarbon color scheme
  -- { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" },
  -- Plugin for the Lush color scheme with a dependency on Zenbones
  -- { "rktjmp/lush.nvim", dependencies = { "mcchrish/zenbones.nvim" } },
  -- {
  --   -- Plugin for the Cyberdream color scheme
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false, -- Load this plugin immediately
  --   priority = 1000, -- High priority to ensure it loads early
  -- },
  -- Plugin for the Doom One color scheme
  -- { "NTBBloodbath/doom-one.nvim", name = "doom-one" },
  -- Plugin for the Aylin color scheme
  -- { "AhmedAbdulrahman/aylin.vim", name = "aylin" },
  -- {
  --   -- Plugin for enabling transparency
  --   "xiyaowong/transparent.nvim",
  -- },
  -- {
  --   -- Plugin for the Bamboo color scheme
  --   "ribru17/bamboo.nvim",
  --   lazy = false, -- Load this plugin immediately
  -- },
  {
    -- Plugin for the Everforest color scheme
    -- {
    --   "neanias/everforest-nvim",
    --   version = false, -- Use the latest version
    --   lazy = false, -- Load this plugin immediately
    --   config = function()
    --     require("everforest").setup({
    --       background = "hard", -- Set the background to 'hard'
    --       italis = true, -- Enable italics
    --       transparent_background_level = 1, -- Uncomment to enable transparency
    --       diagnostic_text_highlight = true, -- Enable diagnostic text highlight
    --       diagnostic_virtual_text = "coloured", -- Set diagnostic virtual text to colored
    --       colours_override = function(palette)
    --         palette.bg0 = "#1A1A22" -- Override background color
    --       end,
    --     })
    --   end,
    -- },
    {
      "sainnhe/everforest",
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        -- Fondo y contraste
        -- vim.g.everforest_background = 'soft'
        -- vim.g.everforest_ui_contrast = 'high'
        -- vim.g.everforest_float_style = 'dim'
        vim.g.everforest_better_performance = 1

        -- Borde redondeado por defecto para ventanas flotantes (Neovim 0.11+)
        vim.o.winborder = 'rounded'

        -- Borde redondeado para diagnósticos flotantes (hover/signature heredan de winborder)
        vim.diagnostic.config({ float = { border = 'rounded' } })

        -- Forzar borde en LSP hover (K) y signature help — Neovim 0.11+ API
        local orig_hover = vim.lsp.buf.hover
        vim.lsp.buf.hover = function(config)
          config = config or {}
          config.border = config.border or 'rounded'
          return orig_hover(config)
        end
        local orig_sig = vim.lsp.buf.signature_help
        vim.lsp.buf.signature_help = function(config)
          config = config or {}
          config.border = config.border or 'rounded'
          return orig_sig(config)
        end

        -- Estilos de texto
        vim.g.everforest_enable_italic = true
        vim.g.everforest_italic_keyword = 1

        -- Resaltado contextual
        -- vim.g.everforest_current_word = 'bold'
        vim.g.everforest_dim_inactive_windows = 1
        vim.g.everforest_inlay_hints_background = 'dimmed'

        -- UI extra
        vim.g.everforest_sign_column_background = 'none'
        vim.g.everforest_show_eob = 0

        -- Diagnósticos: errores con fondo rojito
        vim.g.everforest_diagnostic_text_highlight = 1
        vim.g.everforest_diagnostic_line_highlight = 1
        vim.g.everforest_diagnostic_virtual_text = 'highlighted'
        vim.g.everforest_spell_foreground = 'none'

        -- Override del color de spell + bordes transparentes
        local apply_overrides = function()
          vim.api.nvim_set_hl(0, 'SpellBad',   { fg = '#7a8478', undercurl = true, sp = '#7a8478' })
          vim.api.nvim_set_hl(0, 'SpellCap',   { fg = '#7a8478', undercurl = true, sp = '#7a8478' })
          vim.api.nvim_set_hl(0, 'SpellRare',  { fg = '#7a8478', undercurl = true, sp = '#7a8478' })
          vim.api.nvim_set_hl(0, 'SpellLocal', { fg = '#7a8478', undercurl = true, sp = '#7a8478' })

            -- Bordes y fondos transparentes para flotantes, popups y notificaciones
            local transparent = { bg = 'NONE', ctermbg = 'NONE' }
            local border = { fg = "#FFB0AF", bg = 'NONE', ctermbg = 'NONE', bold = true }

            -- Ventanas flotantes nativas (LSP hover, signature help, diagnostics, etc.)
            vim.api.nvim_set_hl(0, 'NormalFloat',     transparent)
            vim.api.nvim_set_hl(0, 'FloatBorder',     border)
            vim.api.nvim_set_hl(0, 'FloatTitle',      border)
            vim.api.nvim_set_hl(0, 'FloatFooter',     border)

            -- Menú de autocompletado
            vim.api.nvim_set_hl(0, 'Pmenu',           transparent)
            vim.api.nvim_set_hl(0, 'PmenuSbar',       transparent)
            vim.api.nvim_set_hl(0, 'PmenuThumb',      { bg = '#7a8478' })

            -- Mensajes / cmdline (noice, etc.)
            vim.api.nvim_set_hl(0, 'NormalNC',        transparent)
            vim.api.nvim_set_hl(0, 'MsgArea',         transparent)
            vim.api.nvim_set_hl(0, 'MsgSeparator',    border)

            -- nvim-notify
            vim.api.nvim_set_hl(0, 'NotifyBackground',       transparent)
            for _, level in ipairs({ 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE' }) do
              vim.api.nvim_set_hl(0, 'Notify' .. level .. 'Border', { link = 'FloatBorder' })
              vim.api.nvim_set_hl(0, 'Notify' .. level .. 'Body',   transparent)
              vim.api.nvim_set_hl(0, 'Notify' .. level .. 'Title',  { link = 'FloatTitle' })
            end

            -- Telescope
            vim.api.nvim_set_hl(0, 'TelescopeNormal',        transparent)
            vim.api.nvim_set_hl(0, 'TelescopeBorder',        border)
            vim.api.nvim_set_hl(0, 'TelescopePromptNormal',  transparent)
            vim.api.nvim_set_hl(0, 'TelescopePromptBorder',  border)
            vim.api.nvim_set_hl(0, 'TelescopePromptTitle',   border)
            vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', transparent)
            vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', border)
            vim.api.nvim_set_hl(0, 'TelescopeResultsTitle',  border)
            vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', transparent)
            vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', border)
            vim.api.nvim_set_hl(0, 'TelescopePreviewTitle',  border)

            -- Lazy / Mason
            vim.api.nvim_set_hl(0, 'LazyNormal',  transparent)
            vim.api.nvim_set_hl(0, 'MasonNormal', transparent)

            -- which-key
            vim.api.nvim_set_hl(0, 'WhichKeyFloat',  transparent)
            vim.api.nvim_set_hl(0, 'WhichKeyBorder', border)

            -- Noice
            vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup',       transparent)
            vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', border)
            vim.api.nvim_set_hl(0, 'NoicePopup',              transparent)
            vim.api.nvim_set_hl(0, 'NoicePopupBorder',        border)
            vim.api.nvim_set_hl(0, 'NoiceMini',               transparent)

          -- Diagnósticos flotantes
          vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { fg = '#d4565f', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn',  { fg = '#f0c674', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo',  { fg = '#6fa8d8', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint',  { fg = '#7fc4b8', bg = 'NONE' })

          -- snacks.nvim (picker, notifier, input, dashboard)
          for _, g in ipairs({
            'SnacksNormal', 'SnacksNormalNC', 'SnacksWinBar', 'SnacksWinBarNC',
            'SnacksBackdrop',
            'SnacksPicker', 'SnacksPickerInput', 'SnacksPickerList', 'SnacksPickerPreview',
            'SnacksPickerBox', 'SnacksPickerTitle', 'SnacksPickerFooter',
            'SnacksNotifier', 'SnacksNotifierTitle', 'SnacksNotifierIcon', 'SnacksNotifierFooter',
            'SnacksNotifierInfo', 'SnacksNotifierWarn', 'SnacksNotifierError',
            'SnacksNotifierDebug', 'SnacksNotifierTrace',
            'SnacksInput', 'SnacksInputNormal', 'SnacksInputTitle',
            'SnacksDashboardNormal',
          }) do
            vim.api.nvim_set_hl(0, g, { bg = 'NONE', ctermbg = 'NONE' })
          end
          for _, g in ipairs({
            'SnacksPickerBorder', 'SnacksPickerInputBorder', 'SnacksPickerListBorder',
            'SnacksPickerPreviewBorder', 'SnacksPickerBoxBorder',
            'SnacksNotifierBorder',
            'SnacksNotifierBorderInfo', 'SnacksNotifierBorderWarn',
            'SnacksNotifierBorderError', 'SnacksNotifierBorderDebug',
            'SnacksNotifierBorderTrace',
            'SnacksInputBorder', 'SnacksWinBorder',
          }) do
            vim.api.nvim_set_hl(0, g, { fg = '#7a8478', bg = 'NONE', ctermbg = 'NONE' })
          end

          -- fzf-lua
          for _, g in ipairs({
            'FzfLuaNormal', 'FzfLuaPreviewNormal', 'FzfLuaTitle',
            'FzfLuaHelpNormal', 'FzfLuaBackdrop',
          }) do
            vim.api.nvim_set_hl(0, g, { bg = 'NONE', ctermbg = 'NONE' })
          end
          for _, g in ipairs({
            'FzfLuaBorder', 'FzfLuaPreviewBorder', 'FzfLuaHelpBorder', 'FzfLuaTitleFlags',
          }) do
            vim.api.nvim_set_hl(0, g, { fg = '#7a8478', bg = 'NONE', ctermbg = 'NONE' })
          end
        end

        vim.api.nvim_create_autocmd('ColorScheme', {
          pattern = '*',
          callback = apply_overrides,
        })
        vim.api.nvim_create_autocmd({ 'VimEnter', 'User' }, {
          pattern = '*',
          callback = function() vim.schedule(apply_overrides) end,
        })

        -- Paleta "nórdico frío" — acentos desplazados hacia tonos azulados
        vim.g.everforest_colors_override = {
          red    = { '#d4565f', '167' },
          orange = { '#e08a66', '208' },
          yellow = { '#f0c674', '179' },
          green  = { '#a8d080', '142' },
          aqua   = { '#7fc4b8', '108' },
          blue   = { '#6fa8d8', '109' },
          purple = { '#c690b8', '175' },
        }
        -- vim.cmd.colorscheme("everforest")
      end,
    },

    {
      -- Plugin for the Oldworld color scheme
      "dgox16/oldworld.nvim",
      lazy = false, -- Load this plugin immediately
      priority = 1000, -- High priority to ensure it loads early
    },

    -- Plugin for the Rose Pine color scheme
    -- {
    --   "folke/tokyonight.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   opts = {
    --     bold = true,
    --     italic = true,
    --     transparent = true,
    --   },
    -- },

    {
      "rose-pine/neovim",
      name = "rose-pine",
      opts = {
        variant = "moon", -- Set the variant to 'moon'
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      },
    },

    {
      "dgox16/oldworld.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        variant = "oled",
      },
    },

    {
      "eldritch-theme/eldritch.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },

    -- {
    --   "neanias/everforest",
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     -- vim.g.transparent_enabled = true,
    --     vim.g.everforest_enable_italic = true
    --     vim.g.everforest_background = "hard" -- Set the background to 'hard'
    --   end,
    -- },

    {
      "HoNamDuong/hybrid.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        transparency = true,
      },
    },

    {
      "sainnhe/sonokai",
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.sonokai_enable_italic = true
      end,
    },

    {
      "Zeioth/neon.nvim",
      opts = {
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
        },
      },
    },

    {
      "hachy/eva01.vim",
      lazy = false,
      priority = 1000,
    },

    {
      "xero/miasma.nvim",
      lazy = false,
      priority = 1000,
    },

    {
      "ptdewey/darkearth-nvim",
      priority = 1000,
    },

    {
      "anAcc22/sakura.nvim",
      priority = 1000,
    },

    {
      -- Plugin for the Bamboo color scheme
      "ribru17/bamboo.nvim",
      lazy = false, -- Load this plugin immediately
    },

    {
      "2nthony/vitesse.nvim",
      dependencies = {
        "tjdevries/colorbuddy.nvim",
      },
    },

    {
      -- LazyVim configuration
      "LazyVim/LazyVim",
      opts = {
        -- Set the default color scheme
        colorscheme = "everforest",
      },
    },
  },
}
