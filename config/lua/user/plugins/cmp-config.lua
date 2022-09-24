-- makes sure that completion engine is loaded
local cmp_loaded, cmp = pcall(require, 'cmp')
if not cmp_loaded then
	return
end

-- makes sure that snippet engine is loaded
local lua_snip_loaded, luasnip = pcall(require, 'luasnip')
if not lua_snip_loaded then
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
cmp.setup {

	-- specifies snippet plugin
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	-- makes completion windows rounded
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	-- plugin mappings
	mapping = cmp.mapping.preset.insert({
		-- navigation mappings
		['<C-Down>'] = cmp.mapping.select_next_item(),
		['<C-Up>'] = cmp.mapping.select_prev_item(),
		['<C-S>Down'] = cmp.mapping.scroll_docs(-4),
		['<C-S>Up'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),

		-- super-tab mappings
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
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
	sources = cmp.config.sources({
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
