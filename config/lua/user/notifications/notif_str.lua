-- makes sure that notify is loaded
local notify_loaded, _ = pcall(require, 'notify')
if not notify_loaded then
	return
end

local function notif_content(head, body)
	return {
		title = head,
		message = body
	}
end

return {
	no_session_found = notif_content(
		'Error: No Session Found',
		'No local directory "session" was found.\n' ..
		'Try opening a file and starting a new ' ..
		'session with the command "Prosession"'
	)
}
