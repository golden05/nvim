return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      require "configs.html"
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },

  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- 禁用默认 <Tab> 映射，避免冲突
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_comment_map = true

      -- 自定义快捷键
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
      vim.api.nvim_set_keymap("i", "<C-K>", "copilot#Next()", { expr = true, silent = true })
      vim.api.nvim_set_keymap("i", "<C-H>", "copilot#Previous()", { expr = true, silent = true })
    end,
  },
}
