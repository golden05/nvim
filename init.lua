require("_options")
require("_plugins")
require("_lsp")
require("_treesitter")
require("_telescope")
require("_whichkey")
require("_null-ls")
require("_terminal")
require("_autopairs")
vim.cmd("colorscheme tokyonight")

-- important to import after colorscheme
require("_statusline")
local statusline = require('statusline')
statusline.tabline = true
