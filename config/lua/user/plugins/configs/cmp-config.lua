-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that completion engine is loaded
if not plugins.cmp.base then
	return
end

-- makes sure that snippet engine is loaded
if not plugins.luasnip then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- icons to be used by completion engine
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- setting up completion engine
plugins.cmp.base.setup {

	-- specifies snippet plugin
	snippet = {
		expand = function(args)
			plugins.luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	-- makes completion windows rounded
	window = {
		completion = plugins.cmp.base.config.window.bordered(),
		documentation = plugins.cmp.base.config.window.bordered(),
	},

	-- plugin mappings
	mapping = plugins.cmp.base.mapping.preset.insert({
		-- navigation mappings
		['<C-Down>'] = plugins.cmp.base.mapping.select_next_item(),
		['<C-Up>'] = plugins.cmp.base.mapping.select_prev_item(),
		['<C-S>Down'] = plugins.cmp.base.mapping.scroll_docs(-4),
		['<C-S>Up'] = plugins.cmp.base.mapping.scroll_docs(4),
		['<C-Space>'] = plugins.cmp.base.mapping.complete(),
		['<C-e>'] = plugins.cmp.base.mapping.abort(),
		['<CR>'] = plugins.cmp.base.mapping.confirm({ select = true }),

		-- super-tab mappings
		["<Tab>"] = plugins.cmp.base.mapping(function(fallback)
			if plugins.cmp.base.visible() then
				plugins.cmp.base.select_next_item()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = plugins.cmp.base.mapping(function()
			if plugins.cmp.base.visible() then
				plugins.cmp.base.select_prev_item()
			elseif plugins.luasnip.jumpable(-1) then
				plugins.luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),

	-- suggestion format
	formatting = {

		-- completion type | completion | completion source
		fields = { "kind", "abbr", "menu" },

		-- sets completion format
		format = function(entry, vim_item)
			-- gets the completion icon
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

			-- gets completion menu depending on the completion source
			vim_item.menu = ({
				nvim_lsp = "[LSP]",		-- completion from LSP
				nvim_lua = "[LUA]",		-- Lua-specific completion
				luasnip = "[Snippet]",	-- completion is a snippet
				buffer = "[File]",		-- completion come from file
				path = "[Path]",		-- completion is a path to a file
		  	})[entry.source.name]

			-- returns the formatted completion entry
			return vim_item
		end,
	},

	-- order of sources, with lower indices having higher priority
	sources = plugins.cmp.base.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' }
    }),

	-- experimental features
	experimental = {
		ghost_text = true	-- enables completion preview
	}
}
