return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = "VimEnter",

		dependencies = {
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
			"giuxtaposition/blink-cmp-copilot",
			"moyiz/blink-emoji.nvim",
		},

		opts_extend = { "sources.default" },

		opts = {
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot", "emoji" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = -100,
						async = true,
						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						opts = { insert = true },
					},
				},
			},
			keymap = {
				preset = "none",
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<Right>"] = { "snippet_forward", "fallback" },
				["<Left>"] = { "snippet_backward", "fallback" },
				["<C-c>"] = { "hide", "fallback" },
				-- For future @nobe4: using <Enter> messes up all the
				-- newline/confirmation things. Learn to Use <C-y> instead.
				["<C-y>"] = { "select_and_accept" },

			},
			appearance = {
				use_nvim_cmp_as_default = true,

				-- needed until https://github.com/Saghen/blink.cmp/issues/1059
				-- is done
				kind_icons = {
					Copilot = "",
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},

			completion = {
				keyword = { range = "full" },
				ghost_text = { enabled = false },
				menu = {
					draw = {
						columns = {
							{
								"kind",
								gap = 1,
							},
							{
								"label",
								"label_description",
							},
						},
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
				},
			},
			signature = {
				enabled = true,
			},
			snippets = { preset = "luasnip" },
		},

	},
}
