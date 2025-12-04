local llm = require("llm")
llm.setup({
  backend = "ollama",
  model = "qwen3:8b",
  url = "http://localhost:11434",
  prompts = {
    explain = "请解释以下代码：\n\n{{code}}",
    fix = "请修复下面的代码错误：\n\n{{code}}",
    optimize = "请最优化以下代码的可读性和性能：\n\n{{code}}",
    complete = "根据下面内容补全代码：\n\n{{code}}",
    swift = "你是一名专业 Swift 工程师。请按 Swift 最佳实践编写代码：\n\n{{input}}",
  },
  max_tokens = 512,
  show_notification = true,
  send_whole_file = false,
})
