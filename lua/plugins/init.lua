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
    config = function()
      require "configs.live-preview"
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown" },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    config = function()
      require("render-markdown").setup({})
    end,
    opts = {},
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = { { "<leader>cp", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", }, },
    build = function() vim.fn["mkdp#util#install"]() end,
  },


  {
    "nvim-mini/mini.surround",
    recommended = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        add = "gza",            -- Add surrounding in Normal and Visual modes
        delete = "gzd",         -- Delete surrounding
        find = "gzf",           -- Find surrounding (to the right)
        find_left = "gzF",      -- Find surrounding (to the left)
        highlight = "gzh",      -- Highlight surrounding
        replace = "gzr",        -- Replace surrounding
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
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- 必須依賴
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      -- 常用快捷鍵（<leader> 預設是空格，可在 mappings.lua 自訂）
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git File History (當前檔案)" },
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview 開啟 (工作目錄變更)" },
      { "<leader>gD", "<cmd>DiffviewOpen HEAD^<CR>", desc = "Diffview vs 上一個 commit" },
      { "<leader>gm", "<cmd>DiffviewOpen main..<CR>", desc = "Diffview vs main 分支" }, -- 常見 PR 比對
      { "<leader>gc", "<cmd>DiffviewClose<CR>", desc = "關閉 Diffview" },
    },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        -- 基本推薦設定
        enhanced_diff_hl = true, -- 加強 diff 高亮（改動更明顯）
        use_icons = true,        -- 使用圖示（NvChad 已支援 devicons）
        show_help_hints = true,  -- 顯示操作提示

        view = {
          -- layout 選擇：horizontal（上下，適合大螢幕看歷史）或 vertical（左右）
          default = { layout = "diff2_horizontal" },
          file_history = { layout = "diff2_horizontal" },
          merge_tool = { layout = "diff3_horizontal" },
        },

        file_panel = {
          listing_style = "tree", -- tree（樹狀）或 list（列表）
          win_config = {          -- 左側檔案列表面板寬度
            position = "left",
            width = 35,
          },
        },

        -- 快捷鍵覆蓋（預設已很好，可加減）
        keymaps = {
          disable_defaults = false,                    -- 保留官方預設
          view = {
            ["<tab>"]     = actions.select_next_entry, -- 下一個檔案
            ["<s-tab>"]   = actions.select_prev_entry, -- 上一個檔案
            ["gf"]        = actions.goto_file,         -- 跳到檔案
            ["<leader>e"] = actions.focus_files,       -- 聚焦檔案面板
            ["<leader>b"] = actions.toggle_files,      -- 隱藏/顯示檔案面板
          },
          file_panel = {
            ["j"]    = actions.next_entry,
            ["k"]    = actions.prev_entry,
            ["<cr>"] = actions.select_entry,  -- Enter 看 diff
            ["o"]    = actions.open_in_split, -- o 在 split 開舊版檔案
            ["q"]    = actions.close,
          },
        },

        -- 可選：讓舊版 buffer 唯讀，避免誤改
        hooks = {
          diff_buf_read = function(bufnr)
            vim.bo[bufnr].modifiable = false
          end,
        },
      })
    end,
  },

}
