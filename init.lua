require("_options")
require("_plugins")
require("_keybindings")
require("_lsp")
require("_nvimtree")
require("_treesitter")
require("_nvimtree")
require("_telescope")
require("_whichkey")
require("_null-ls")
require("_autopairs")
require("_toggleterm")
require("_dap-ruby")
vim.cmd("colorscheme tokyonight")

-- important to import after colorscheme
require("_statusline")
local statusline = require('statusline')
statusline.tabline = true
