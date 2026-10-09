return {
  {
    "nvim-java/nvim-java",
    -- version = "3.0.0",
    -- v4 trae java-core, java-refactor, etc. dentro; los plugins viejos los tapan y rompen setup()
    -- dependencies = {
    --   "nvim-java/lua-async-await",
    --   "nvim-java/nvim-java-core",
    --   "nvim-java/nvim-java-test",
    --   "nvim-java/nvim-java-dap",
    --   "nvim-java/nvim-java-refactor",
    --   "MunifTanjim/nui.nvim",
    --   "neovim/nvim-lspconfig",
    --   "mason-org/mason.nvim",
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
          -- java_version = false, -- agrega esto
        },
        -- settings = {
        --   java = {
        --     format = {
        --       enabled = true,
        --       settings = {
        --         url = vim.fn.expand("~/.config/nvim/formaterJava/java_formater.xml"),
        --         profile = "javaFormater",
        --       },
        --     },
        --   },
        -- },
        jdtls = {
          enable = true,
          auto_install = true,
          -- version = "1.52.0",
          -- v4 ignora jvm_args; se pasan abajo con JDK_JAVA_OPTIONS
          jvm_args = {
            "-Xmx4g",
            "-XX:+UseG1GC",
            "-XX:GCTimeRatio=4",
            "-XX:AdaptiveSizePolicyWeight=90",
            "-Dsun.zip.disableMemoryMapping=true",
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
          auto_install = true,
          -- version = "1.18.40",
          -- path = "/usr/share/java/lombok.jar",
        },
        java_test = {
          enable = true,
          -- version = "0.43.1", -- no compatible con jdtls 1.54 (asm)
          -- version = "0.40.1",
        },
        spring_boot_tools = {
          enable = true,
          auto_install = true,
          -- version = "1.55.1",
          -- path = "/usr/local/share/java/spring-boot/",
          -- version = "1.59.0", -- el paquete no trae BootLanguageServerBootApp
        },

        java_debug_adapter = {
          enable = true,
          -- version = "0.58.2",
        },
        mason = {
          registries = {
            "github:nvim-java/mason-registry",
          },
        },
        -- Logging
        log = {
          use_console = false,
          use_file = true,
          level = "warn",
          log_file = vim.fn.stdpath("state") .. "/nvim-java.log",
          max_lines = 1000,
          show_location = false,
        },
      })
      vim.lsp.set_log_level("warn")
      vim.lsp.config("jdtls", {
        cmd_env = {
          JDK_JAVA_OPTIONS = "-Xmx4g -XX:+UseG1GC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true",
        },
      })
      -- require("lspconfig").jdtls.setup({}) -- v3; en v4 se usa vim.lsp.enable
      vim.lsp.enable("jdtls")
    end,
  },
}
