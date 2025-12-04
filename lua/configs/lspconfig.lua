require("nvchad.configs.lspconfig").defaults()
local servers = { "postgres_lsp", "sourcekit", "html", "cssls", "emmet-ls", "pyright", "rust_analyzer", "ts_ls", "tailwindcss","eslint" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
