local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	completion = {
		autocomplete = false,
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	mapping = {
		-- ["<C-c>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<Enter>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-p>"] = cmp.mapping.select_prev_item(),
		-- `C-n` triggers the completion, and goes to the next item
		-- Luasnip uses C-j C-k for jumping
		-- ref: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
	}, {
		{ name = "path" },
		{
			name = "buffer",
			option = {
				-- Complete from all open buffers
				get_bufnrs = vim.api.nvim_list_bufs,
			},
		},
	}),
})

-- TODO: Find a way to get back auto-complete on those fields
-- cmp.setup.cmdline({ "/", "?" }, {
-- 	completion = {
-- 		autocomplete = true,
-- 	},
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = {
-- 		{ name = "buffer" },
-- 	},
-- })
--
-- cmp.setup.cmdline(":", {
-- 	completion = {
-- 		autocomplete = true,
-- 	},
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = cmp.config.sources({
-- 		{ name = "path" },
-- 	}, {
-- 		{ name = "cmdline" },
-- 		{ name = "buffer" },
-- 	}),
-- })
