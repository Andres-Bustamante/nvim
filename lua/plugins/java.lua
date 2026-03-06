return {
  {
    "nvim-java/nvim-java",
    -- ft = { "java" },
    -- dependencies = {
    --   "nvim-java/lua-async-await",
    --   "nvim-java/nvim-java-core",
    --   "nvim-java/nvim-java-test",
    --   "nvim-java/nvim-java-dap",
    --   "nvim-java/nvim-java-refactor",
    --   "MunifTanjim/nui.nvim",
    --   "neovim/nvim-lspconfig",
    -- },
    config = function()
      -- vim.lsp.handlers["workspace/executeClientCommand"] = function(err, result, ctx, config)
      --   return {}
      -- end
      require("java").setup({
        check_node = false,
        checks = {
          nvim_version = true, -- Check Neovim version
          nvim_jdtls_conflict = true, -- Check for nvim-jdtls conflict
        },
        jdtls = {
          enable = true,
          auto_install = true,
          verison = "1.43.0",
          settings = {
            java = {
              format = {
                enabled = true,
                settings = {
                  url = "file:///home/desarrollo/.config/nvim/lua/config/formater/java.xml",
                  profile = "javaFormater",
                },
              },
            },
          },
          -- -202412191447",
          -- version = "1.43.0-202412191447",
          -- javaagent = vim.fn.expand("~/.local/share/java/lombok.jar"),
          -- jvm = {
          --   jdk = {
          --     name = "JavaSE-21",
          --     path = "/usr/lib/jvm/java-21-openjdk-amd64",
          --     default = true,
          --   },
          -- },
          -- cmd = {
          --   "java",
          --   "/usr/lib/jvm/java-21-openjdk-amd64/bin/java", -- Usa JDK 21
          --   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          --   "-Dosgi.bundles.defaultStartLevel=4",
          --   "-Declipse.product=org.eclipse.jdt.ls.core.product",
          --   "-Dlog.protocol=true",
          --   "-Dlog.level=ALL",
          --   "-Xmx4g",
          --   "--add-modules=ALL-SYSTEM",
          --   "--add-opens",
          --   "java.base/java.util=ALL-UNNAMED",
          --   "--add-opens",
          --   "java.base/java.lang=ALL-UNNAMED",
          --   "-jar",
          --   vim.fn.glob(
          --     "~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
          --   ),
          --   "-javaagent:",
          --   "~/.local/share/java/lombok.jar",
          --   "-configuration",
          --   "~/.local/share/nvim/mason/packages/jdtls/config_linux/",
          -- },
        },

        jdk = {
          auto_install = false,
          version = "21",
          path = "/usr/lib/jvm/java-21-openjdk-amd64",
        },
        lombok = {
          enable = true,
          auto_install = false,
          -- version = "1.18.40",
          path = "/usr/share/java/lombok.jar",
        },
        java_test = {
          enable = true,
          -- version = "0.43.1",
          version = "0.40.1",
        },
        spring_boot_tools = {
          enable = true,
          auto_install = false,
          -- version = "1.55.1",
          path = "/usr/local/share/java/spring-boot/",
          -- version = "1.59.0",
        },
        java_debug_adapter = {
          enable = true,
          version = "0.58.2",
        },
        mason = {
          registries = {
            "github:nvim-java/mason-registry",
          },
        },
        -- Logging
        log = {
          use_console = true,
          use_file = true,
          level = "info",
          log_file = vim.fn.stdpath("state") .. "/nvim-java.log",
          max_lines = 1000,
          show_location = false,
        },
      })
      vim.lsp.enable("jdtls")
    end,
  },
}
