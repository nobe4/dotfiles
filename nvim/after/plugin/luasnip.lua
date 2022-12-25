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
describe $1 do
  context "#$2" do
    it "$3" do
      $4
    end
  end
end]]
	),

	ls.parser.parse_snippet(
		"before",
		[[
before(:each) do
  $1
end]]
	),

	ls.parser.parse_snippet(
		"context",
		[[
context "#$1" do
  it "$2" do
    $3
  end
end]]
	),

	-- spec double
	-- TODO: have a choice between the `let` and the `X =`
	ls.parser.parse_snippet("double", [[let(:$1) { double("$1") }]]),
	ls.parser.parse_snippet("pry", [[require "pry-byebug"; binding.pry]]),
	ls.parser.parse_snippet("debug", [[require "pry-byebug"; binding.pry]]),
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