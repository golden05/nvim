require("nvchad.configs.lspconfig").defaults()
local servers = { "tsserver", "postgres_lsp", "sourcekit", "html-lsp", "html", "cssls", "emmet-ls", "ruff", "rust_analyzer", "ts_ls",
  "lemminx","marksman",
  "tailwindcss", "eslint", "unocss" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
