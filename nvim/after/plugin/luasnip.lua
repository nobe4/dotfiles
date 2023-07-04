local ls = require("luasnip")

-- config
ls.config.setup({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

-- snippets
ls.add_snippets("ruby", {
	-- spec describe
	ls.parser.parse_snippet(
		"describe",
		[[
describe "#$1" do
  it "$2" do
    $3
  end
end]]
	),

	ls.parser.parse_snippet(
		"before",
		[[
before do
  $1
end]]
	),

	ls.parser.parse_snippet(
		"context",
		[[
context "$1" do
  it "$2" do
    $3
  end
end]]
	),

	-- spec double
	-- TODO: have a choice between the `let` and the `X =`
	ls.parser.parse_snippet("let", [[let(:$1) { "$1" }]]),
	ls.parser.parse_snippet("double", [[let(:$1) { double("$1") }]]),
	ls.parser.parse_snippet("pry", [[require "pry-byebug"; binding.pry]]),
})

ls.add_snippets("go", {
	ls.parser.parse_snippet("test", 'func Test${1:Name}(t *testing.T) {${2:t.Skip("TODO")}}'),
	ls.parser.parse_snippet("run", 't.Run("$1", func(t *testing.T) {${2:t.Skip("TODO")}})'),
})

ls.add_snippets("gitcommit", {
	ls.parser.parse_snippet("missing", "Remove missing team"),
	ls.parser.parse_snippet("empty", "Remove empty team"),
})

-- mappings
vim.keymap.set({ "i", "s" }, "<C-K>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-J>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-L>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
