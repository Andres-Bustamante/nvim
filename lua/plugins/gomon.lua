return {
  "azpect3120/gomon.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gomon").setup({
      window = {
        style = "float",
        size = "medium",
        title = " GoMon Output... ",
        border = "rounded",
        wrap = false,
      },
      -- Open the output window on start
      display_on_start = true,
      -- Close the output window on stop
      close_on_stop = false,
    })
    vim.keymap.set("n", "<leader>Cgs", "<cmd>Gomon start<CR>", { desc = "Start Gomon (RunGo Program)" })
    vim.keymap.set("n", "<leader>Cgt", "<cmd>Gomon stop<CR>", { desc = "Stop Gomon" })
    vim.keymap.set("n", "<leader>Cgh", "<cmd>Gomon hide<CR>", { desc = "Hide Gomon window" })
    vim.keymap.set("n", "<leader>Cgw", "<cmd>Gomon show<CR>", { desc = "Show Gomon window" })
  end,
}
