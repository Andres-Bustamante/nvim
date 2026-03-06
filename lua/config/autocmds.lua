-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost" }, {
  callback = function(args)
    local ok, snacks = pcall(require, "snacks.toggle")
    if not ok then
      return
    end

    if not snacks.get("inlay_hints") then
      vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
    end
  end,
})
