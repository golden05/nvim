local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end
return packer.startup(function()
  use({
    "L3MON4D3/LuaSnip",
    "casonadams/walh",
    "folke/trouble.nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "jose-elias-alvarez/null-ls.nvim",
    "neovim/nvim-lspconfig",
    "nvim-lua/lsp-status.nvim",
    "nvim-treesitter/nvim-treesitter",
    "saadparwaiz1/cmp_luasnip",
    "tamago324/nlsp-settings.nvim",
    "wbthomason/packer.nvim",
    "williamboman/nvim-lsp-installer",
  })
  use({
    "rafamadriz/friendly-snippets",
    require("luasnip").filetype_extend("ruby", {"rails"})
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use {"nvim-telescope/telescope-file-browser.nvim"}
  use {
    "nanozuki/tabby.nvim",
    config = function() require("tabby").setup() end,
}
  use({
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt = true },
  })
  use({
    "akinsho/bufferline.nvim", 
    requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }
  })
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })
  use({
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({})
    end,
  })
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ yadm = { enable = true } })
    end,
  })
  use({
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end,
  })
  
  use({
    'junnplus/nvim-lsp-setup',
    requires = {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
    }
  })


  -- nvim-autopairs
  use("windwp/nvim-autopairs")
    -- surround
  use("ur4ltz/surround.nvim")
        -- gruvbox
  use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
        -- tokyonight
  use("folke/tokyonight.nvim")
  use("EdenEast/nightfox.nvim")
  use('mfussenegger/nvim-dap')
  use('suketa/nvim-dap-ruby')
  use('beauwilliams/statusline.lua')
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  use('github/copilot.vim')
  use("akinsho/toggleterm.nvim")
  use("tpope/vim-rails")
  use("tpope/vim-endwise")
  use("thoughtbot/vim-rspec")

  use("windwp/emmet-ls")
 

  if packer_bootstrap then
    require("packer").sync()
  end
end)
