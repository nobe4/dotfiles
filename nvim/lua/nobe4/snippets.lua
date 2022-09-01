-- breaking changes listed here
-- https://github.com/L3MON4D3/LuaSnip/issues/81
local ls = require("luasnip")

ls.add_snippets('all', {
  ls.parser.parse_snippet("expand", "-- expanded !"),
})

ls.add_snippets('ruby', {
  -- spec describe
  ls.parser.parse_snippet("describe",
[[describe "$1" do
  context "#$2" do
    it "$3" do
    end
  end
end]]
),
  ls.parser.parse_snippet("double", [[let(:$1) { double("$1") }]]),
})
