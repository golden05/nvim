require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- 跑当前测试（光标所在）
vim.keymap.set("n", "<leader>tt", function()
  require("neotest").run.run()
end)

-- 跑当前文件
vim.keymap.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end)

-- 打开测试树（非常重要🔥）
vim.keymap.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end)

-- 查看错误输出（traceback）
vim.keymap.set("n", "<leader>to", function()
  require("neotest").output.open({ enter = true })
end)

-- 重新运行上一次测试（很实用）
vim.keymap.set("n", "<leader>tr", function()
  require("neotest").run.run_last()
end)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
