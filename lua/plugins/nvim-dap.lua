-- This file contains the configuration for the nvim-dap plugin in Neovim.

return {
  {
    -- Plugin: nvim-dap
    -- URL: https://github.com/mfussenegger/nvim-dap
    -- Description: Debug Adapter Protocol client implementation for Neovim.
    "mfussenegger/nvim-dap",
    recommended = true, -- Recommended plugin
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      -- Plugin: nvim-dap-ui
      -- URL: https://github.com/rcarriga/nvim-dap-ui
      -- Description: A UI for nvim-dap.
      "rcarriga/nvim-dap-ui",

      -- Plugin: nvim-dap-virtual-text
      -- URL: https://github.com/theHamsta/nvim-dap-virtual-text
      -- Description: Virtual text for the debugger.
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {}, -- Default options
      },
    },

    -- Keybindings for nvim-dap
    keys = {
      { "<leader>d", "", desc = "+debug", mode = { "n", "v" } }, -- Group for debug commands
      -- { "<M-j>", function() require("dap").step_over() end, desc = "DAP Step Over" },
      -- { "<M-k>", function() require("dap").continue() end, desc = "DAP Continue" },
      -- { "<M-h>", function() require("dap").step_into() end, desc = "DAP Step Into" },
      -- { "<M-l>", function() require("dap").step_out() end, desc = "DAP Step Out" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },

    config = function()
      local dap = require("dap")

      -- Load mason-nvim-dap if available
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      -- Set highlight for DapStoppedLine
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- Define signs for DAP
      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] })
      end

      -- Setup DAP configuration using VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- Load launch configurations from .vscode/launch.json if it exists
      -- if vim.fn.filereadable(".vscode/launch.json") then
      --   vscode.load_launchjs()
      -- end

      -- Function to load environment variables
      local function load_env_variables()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          variables[k] = v
        end

        -- Load variables from .env file manually
        local env_file_path = vim.fn.getcwd() .. "/.env"
        local env_file = io.open(env_file_path, "r")
        if env_file then
          for line in env_file:lines() do
            for key, value in string.gmatch(line, "([%w_]+)=([%w_]+)") do
              variables[key] = value
            end
          end
          env_file:close()
        else
          print("Error: .env file not found in " .. env_file_path)
        end
        return variables
      end

      -- Add the env property to each existing Go configuration
      for _, config in pairs(dap.configurations.go or {}) do
        config.env = load_env_variables
      end

      -- Java attach configs (WildFly + Spring standalone) para sigafc-deploy.sh
      dap.configurations.java = dap.configurations.java or {}
      table.insert(dap.configurations.java, {
        type = "java",
        request = "attach",
        name = "Attach WildFly (sigafc :8787)",
        hostName = "127.0.0.1",
        port = 8787,
        mainClass = "",
        projectName = "",
      })
      table.insert(dap.configurations.java, {
        type = "java",
        request = "attach",
        name = "Attach Spring (sigafc :5005)",
        hostName = "127.0.0.1",
        port = 5005,
        mainClass = "",
        projectName = "",
      })

      dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
      }
      -- Configuración para debuggear Angular en Chrome
      for _, lang in ipairs({ "typescript", "javascript" }) do
        dap.configurations[lang] = dap.configurations[lang] or {}
        table.insert(dap.configurations[lang], {
          type = "pwa-chrome",
          request = "launch",
          name = "Angular: launch Chrome (:4200)",
          url = "http://localhost:4200",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          userDataDir = false,
        })
        table.insert(dap.configurations[lang], {
          type = "pwa-chrome",
          request = "attach",
          name = "Angular: attach Chrome (:9222)",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        })

        table.insert(dap.configurations[lang], {
          name = "Angular: launch Firefox (:4200)",
          type = "firefox",
          request = "launch",
          reAttach = true,
          url = "http://localhost:4200",
          webRoot = "${workspaceFolder}",
          firefoxExecutable = "/home/desarrollo/Downloads/firefox-140.0b2/firefox/firefox",
          pathMappings = {
            { url = "http://localhost:4200", path = "${workspaceFolder}" },
            { url = "webpack://", path = "${workspaceFolder}/" },
          },
        })

        table.insert(dap.configurations[lang], {
          name = "Angular: attach Firefox (:6000)",
          type = "firefox",
          request = "attach",
          url = "http://localhost:4200",
          webRoot = "${workspaceFolder}",
          port = 6000,
        })
      end
    end,
  },
}
