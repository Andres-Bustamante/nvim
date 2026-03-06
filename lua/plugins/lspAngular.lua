local util = require("lspconfig.util")
local lspconfig = require("lspconfig")

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      angularls = {
        -- cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/ngserver"), "--stdio" },
        root_dir = util.root_pattern("angular.json", "nx.json", "project.json", "package.json"),
        --   on_new_config = function(new_config, new_root_dir)
        --     local node_modules = new_root_dir .. "/node_modules"
        --     new_config.cmd = {
        --       vim.fn.expand("~/.local/share/nvim/mason/bin/ngserver"),
        --       "--stdio",
        --       "--tsProbeLocations",
        --       node_modules,
        --       "--ngProbeLocations",
        --       node_modules,
        --     }
        --   end,
        --
        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
        on_new_config = function(new_config, new_root_dir)
          -- Esto busca dinámicamente el core de Angular en el proyecto actual
          local node_modules = new_root_dir .. "/node_modules"
          new_config.cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            node_modules,
            "--ngProbeLocations",
            node_modules,
          }
        end,
      },

      emmet_ls = {
        filetypes = { "html", "css", "htmlangular" },
      },
    },
    setup = {

      -- Configuración para Angular Language Server
      angularls = function(_, _)
        lspconfig.angularls.setup({
          cmd = {
            "/home/desarrollo/.local/share/nvim/mason/bin/ngserver",
            "--ngProbeLocations",
            "/home/desarrollo/Documents/Proyectos/Sigafc/Frontend/node_modules",
          },
        })
        return true
      end,

      html = function(_, opts)
        require("lspconfig").html.setup({
          filetypes = { "html", "htmlangular" },
          init_options = {
            provideFormatter = true,
          },
          settings = opts.settings,
        })
        return true
      end,
    },
  },
}

-- return {
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       angularls = {
--         root_dir = util.root_pattern("angular.json", "nx.json", "project.json", "package.json"),
--       },
--     },
--   },
-- }
