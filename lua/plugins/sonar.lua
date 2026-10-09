return {
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    config = function()
      require("sonarlint").setup({
        server = {
          cmd = {
            "sonarlint-language-server",
            "-stdio",
            "-analyzers",
            vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjava.jar"),
            vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjs.jar"),
          },
        },
        filetypes = {
          "java",
          "javascript",
          "typescript",
        },
      })
    end,
  },
}
