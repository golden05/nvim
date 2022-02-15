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
    "rafamadriz/friendly-snippets",
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
    -- nvim-autopairs
  use("windwp/nvim-autopairs")
    -- surround
  use("blackCauldron7/surround.nvim")
        -- gruvbox
  use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
        -- tokyonight
  use("folke/tokyonight.nvim")
  use("EdenEast/nightfox.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  -- Python & Jupyter Notebooks
  use 'bfredl/nvim-ipy'
  use 'hkupty/iron.nvim'
  use 'Vimjas/vim-python-pep8-indent'
  use {'heavenshell/vim-pydocstring', run = 'make install'}
  use 'untitled-ai/jupyter_ascending.vim'
  use 'GCBallesteros/jupytext.vim'
  use 'kana/vim-textobj-line'
  use 'kana/vim-textobj-user'
  use 'GCBallesteros/vim-textobj-hydrogen'





  if packer_bootstrap then
    require("packer").sync()
  end
end)
