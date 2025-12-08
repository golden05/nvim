return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
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
    "brianhuster/live-preview.nvim",
    dependencies = {
      -- You can choose one of the following pickers
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
      "folke/snacks.nvim",
    },
    lazy = false,
    config = function ()
      require "configs.live-preview"
    end,
  },

  {
    "nvim-mini/mini.surround",
    recommended = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
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
