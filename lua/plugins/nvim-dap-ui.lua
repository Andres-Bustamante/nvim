return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap", -- ¡Asegúrate de que esto esté descomentado!
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      layouts = {
        {
          position = "right",
          size = 60,
          elements = {
            { id = "scopes", size = 1.0 },
          },
        },
        {
          position = "bottom",
          size = 10,
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
        },
      },
    })

    -- Opcional: autoabrir/cerrar UI cuando comience o termine el debug
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
