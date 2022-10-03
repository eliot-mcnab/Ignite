-- makes sure that trouble is loaded
local trouble_loaded, trouble = pcall(require, 'trouble')
if not trouble_loaded then
	return
end

-- automatically refreshes trouble on buffer enter
--vim.api.nvim_create_autocmd(
	--'BufEnter',
	--{
		--group = vim.api.nvim_create_augroup(
			--'trouble_plug_autocmd',
			--{
				--clear = true
			--}
		--),
		--command = 'TroubleRefresh'
	--}
--)

-- setting up trouble
trouble.setup {
	-- set up trouble here
}
