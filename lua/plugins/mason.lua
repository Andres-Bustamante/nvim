return {
  {

    "mason-org/mason.nvim",
    -- version = "^1.0.0",
    opts = {
      PATH = "prepend",
      log_level = vim.log.levels.DEBUG,
      ui = {
        check_outdated_packages_on_open = false, -- Evita que Node salte antes de tiempo
        border = "rounded",
        width = 0.85,
        height = 0.85,
        icons = {
          package_installed = "",
          package_pending = "➜",
          package_uninstalled = "",
        },
      },
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    -- version = "^1.0.0",
  },
}
