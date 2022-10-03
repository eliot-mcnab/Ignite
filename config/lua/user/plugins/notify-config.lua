-- makes sure that notify was loaded correctly
local notify_loaded, notify = pcall(require, 'notify')
if not notify_loaded then
	return
end

-- sets up notify
notify.setup {
	stages = "slide",
	background_colour = "#000000"
}
