require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    ruby = { "rubocop" },
    python = { "black" },
    golang = { "gofmt", "goimports" },
    javascript = { "prettier" },
    graphql = { "prettier" },
    -- TODO: add for yaml
    -- formatting.yamlfmt.with({
    -- 	extra_args = { "--formatter", "indentless_arrays=true,retain_line_breaks=true" },
    -- }),
  },
  formatters = {
    rubocop = {
      command = require("nobe4.tool.rubocop").command(),
    },
  },
})
