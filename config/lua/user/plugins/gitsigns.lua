-- makes sure that gitsigns was loaded
local gitsigns_loaded, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_loaded then
	return
end


-- sets up gitsigns
gitsigns.setup(
	-- setup gitsigns here
)
