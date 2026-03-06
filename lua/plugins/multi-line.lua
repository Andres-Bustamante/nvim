-- This file contains the configuration for the vim-multiple-cursors plugin in Neovim.

return {
  {
    -- Plugin: vim-multiple-cursors
    -- URL: https://github.com/terryma/vim-multiple-cursors
    -- Description: A Vim plugin that allows multiple cursors for simultaneous editing.
    -- "mg979/vim-visual-multi",
  },

  -- lazy.nvim:
  -- {
  --   "smoka7/multicursors.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvimtools/hydra.nvim",
  --   },
  --   opts = {},
  --   cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  --   keys = {
  --     {
  --       mode = { "v", "n" },
  --       "<Leader>m",
  --       "<cmd>MCstart<cr>",
  --       desc = "Create a selection for selected text or word under the cursor",
  --     },
  --   },
  -- },
}
