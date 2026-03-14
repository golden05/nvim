require "nvchad.options"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
-- add yours here!
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.shiftwidth = 8
        vim.opt.tabstop = 8
        vim.opt.softtabstop = 8
    end,
})


-- o.cursorlineopt ='both' -- to enable cursorline!
