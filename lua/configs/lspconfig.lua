require("nvchad.configs.lspconfig").defaults()
local servers = { "postgres_lsp", "sourcekit", "html-lsp", "html", "cssls", "emmet-ls", "pyright", "rust_analyzer", "ts_ls",
  "lemminx",
  "tailwindcss", "eslint", "unocss" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
