require 'lspconfig'.solargraph.setup {}

local utils_ok, utils = pcall(require, "utils")
if not utils_ok then
  return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  return
end

local lsp_status_ok, lsp_status = pcall(require, "lsp-status")
if not lsp_status_ok then
  return
end

local win_ok, win = pcall(require, "lspconfig.ui.windows")
if not win_ok then
  return
end

local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
  return
end

local nlspsettings_ok, nlspsettings = pcall(require, "nlspsettings")
if not nlspsettings_ok then
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  return
end

local _default_opts = win.default_opts

nlspsettings.setup()

-- round some of the window borders
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = "rounded"
  return opts
end

-- statusline progress setup
lsp_status.config({
  current_function = false,
  show_filename = false,
  diagnostics = false,
  status_symbol = "",
  select_symbol = nil,
  update_interval = 200,
})

-- completion setup

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    -- { name = "ultisnips" },
    -- { name = "vsnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

completeopt = menu, menuone, noselect

-- function to attach completion when setting up lsp
local on_attach = function(client)
  lsp_status.register_progress()
  lsp_status.on_attach(client)
  utils.bufmap("n", "ga", "lua vim.lsp.buf.code_action()")
  utils.bufmap("n", "gD", "lua vim.lsp.buf.declaration()")
  utils.bufmap("n", "gd", "lua vim.lsp.buf.definition()")
  utils.bufmap("n", "ge", "lua vim.lsp.diagnostic.goto_next()")
  utils.bufmap("n", "gE", "lua vim.lsp.diagnostic.goto_prev()")
  utils.bufmap("n", "gi", "lua vim.lsp.buf.implementation()")
  utils.bufmap("n", "gr", "lua vim.lsp.buf.references()")
  utils.bufmap("n", "K", "lua vim.lsp.buf.hover()")
  utils.bufmap("n", "gl", "lua vim.lsp.diagnostic.show_line_diagnostics()")
end

-- Provide settings first!
lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

local nvim_lsp = require('lspconfig')
local configs = require('lspconfig/configs')
local util = nvim_lsp.util

local sumneko_root_path
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
  sumneko_root_path = vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
  sumneko_root_path = vim.fn.stdpath("data") .. "/lsp_servers/lua/lua-language-server"
elseif vim.fn.has("win32") == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua", "--locale=zh-cn" },
  filetypes = { "lua" },
  log_level = 2,
  root_dir = util.root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "selene.toml", ".git"),
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true
}



local servers = { "solargraph", "html" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()                                                                 
capabilities.textDocument.completion.completionItem.snippetSupport = true

configs.emmet_ls = {
  default_config = {
    cmd = {'emmet-ls', '--stdio'};
    filetypes = {'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' };
    root_dir = function()
      return vim.loop.cwd()
    end;
    settings = {};
  };
}

nvim_lsp.emmet_ls.setup{
  on_attach = on_attach;
}


nvim_lsp.html.setup {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetype = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  },
  settings = {},
  single_file_support = true
}

nvim_lsp.tsserver.setup{
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = { hostInfo = "neovim" },
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
}

nvim_lsp.svelte.setup{
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_dir = util.root_pattern("package.json", ".git")
}

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = { debounce_text_changes = 150 },
  }
  server:setup(opts)
end)

-- diagnostics
vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  float = {
    source = "always",
  },
  severity_sort = true,
  --[[ virtual_text = {
      prefix = "»",
      spacing = 4,
    }, ]]
  signs = true,
  update_in_insert = false,
})


local function prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then return lib end
  return nil
end

local luasnip = prequire('luasnip')
local cmp = prequire("cmp")

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if cmp and cmp.visible() then
    cmp.select_next_item()
  elseif luasnip and luasnip.expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
  elseif check_back_space() then
    return t "<Tab>"
  else
    cmp.complete()
  end
  return ""
end
_G.s_tab_complete = function()
  if cmp and cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip and luasnip.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  else
    return t "<S-Tab>"
  end
  return ""
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

require("luasnip.loaders.from_vscode").load()
