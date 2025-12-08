local options = {

  formatters_by_ft = {
    lua = { "stylua" },
    css = { "biome" },
    html = { "biome" },
  },

  formatters = {
    biome = {
      command = "biome",
      args = {
        "format",
        "--write",
        "$FILENAME",
      },
      stdin = false,
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
