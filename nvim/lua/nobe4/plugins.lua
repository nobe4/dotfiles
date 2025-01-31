-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local options = {
	default = { lazy = true },
	ui = { border = "rounded" },
}

-- Configs are in after/plugin
local plugins = {
	-- Local
	-- { dir = "~/dev/nobe4/withhold.nvim" },
	-- { dir = "~/dev/nobe4/relativity.nvim" },
	-- "nobe4/relativity.nvim",

	-- Misc
	"nobe4/exchange.vim",
	"nobe4/curl.vim",
	"nobe4/vimcorrect",

	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-surround",
	"editorconfig/editorconfig-vim",
	"junegunn/vim-easy-align",
	"mbbill/undotree",
	"romainl/vim-qf",
	{ "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end },
	{ "hat0uma/csvview.nvim",        config = function() require("csvview").setup() end },
	{
		dir = "~/dev/nobe4/obsidian.nvim",
		-- "epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- UI
	"nvim-tree/nvim-web-devicons",

	-- OS
	"stevearc/oil.nvim",
	"danro/rename.vim",

	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	-- "nvim-treesitter/nvim-treesitter-context",

	-- Completion
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
	},
	"zbirenbaum/copilot-cmp",

	-- Snippet
	"L3MON4D3/LuaSnip",

	-- LSP
	"neovim/nvim-lspconfig",

	-- Mason
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Formatter
	"stevearc/conform.nvim",
	"folke/trouble.nvim",

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Completion
	-- "hrsh7th/nvim-cmp",
	-- "hrsh7th/cmp-buffer",
	-- "hrsh7th/cmp-path",
	-- "hrsh7th/cmp-nvim-lsp",
	-- "hrsh7th/cmp-cmdline",
	-- "hrsh7th/cmp-nvim-lua",
	-- "hrsh7th/cmp-nvim-lsp-signature-help",
	-- "saadparwaiz1/cmp_luasnip",
	"giuxtaposition/blink-cmp-copilot",
	{
		'saghen/blink.cmp',
		version = '*',

		dependencies = {
			{ 'L3MON4D3/LuaSnip', version = 'v2.*', },
			"giuxtaposition/blink-cmp-copilot",
			"moyiz/blink-emoji.nvim",
		},

		-- TODO: move this in a file

		opts = {
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot", "emoji" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
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
					}
				},
			},
			keymap = {
				preset = 'none',
				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<Right>'] = { 'snippet_forward', 'fallback' },
				['<Left>'] = { 'snippet_backward', 'fallback' },
				['<C-c>'] = { 'hide', 'fallback' },
				-- For future @nobe4: using <Enter> messes up all the
				-- newline/confirmation things. Learn to Use <C-y> instead.
				['<C-y>'] = { 'select_and_accept' },

			},
			appearance = {
				use_nvim_cmp_as_default = true,

				-- needed until https://github.com/Saghen/blink.cmp/issues/1059
				-- is done
				kind_icons = {
					Copilot = "",
					Text = '󰉿',
					Method = '󰊕',
					Function = '󰊕',
					Constructor = '󰒓',

					Field = '󰜢',
					Variable = '󰆦',
					Property = '󰖷',

					Class = '󱡠',
					Interface = '󱡠',
					Struct = '󱡠',
					Module = '󰅩',

					Unit = '󰪚',
					Value = '󰦨',
					Enum = '󰦨',
					EnumMember = '󰦨',

					Keyword = '󰻾',
					Constant = '󰏿',

					Snippet = '󱄽',
					Color = '󰏘',
					File = '󰈔',
					Reference = '󰬲',
					Folder = '󰉋',
					Event = '󱐋',
					Operator = '󰪚',
					TypeParameter = '󰬛',
				},
			},
			completion = {
				keyword = { range = 'full' },
				ghost_text = { enabled = false, },
				menu = {
					border = 'rounded',
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
						treesitter = { 'lsp' }
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
					window = { border = 'rounded' }
				},
			},
			signature = {
				enabled = true,
				window = { border = 'rounded' }
			},
			snippets = { preset = 'luasnip' },
		},
		opts_extend = { "sources.default" }
	}

	-- Debugger
	-- "mfussenegger/nvim-dap",
	-- "leoluz/nvim-dap-go",
	-- "rcarriga/nvim-dap-ui",
}

require("lazy").setup(plugins, options)
