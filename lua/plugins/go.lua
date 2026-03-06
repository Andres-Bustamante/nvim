return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
  },
  ft = { "go", "gomod" },
  opts = {
    lsp_inlay_hints = {
      enable = false,
    },
  },

  config = function(_, opts)
    require("go").setup(opts)

    local group = vim.api.nvim_create_augroup("GoFormat", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      group = group,
      callback = function()
        require("go.format").goimports()
      end,
    })
  end,
}
