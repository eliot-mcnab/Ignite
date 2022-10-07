-- dependencies
local class = require 'user.ignite_core.ignite_classes'

-- represents a notification as used in by notify
local Notification = class.new('notification')

Notification.add_error {
	not_a_message = 'Incompatible message type,' ..
		'Notification message must be a string',
	not_a_title = 'Incompatible title type' ..
		'Notification title must be a string',
}

-- represents the type of a notification
Notification.Type = class.new('notif_type')

Notification.Type.add_error {
	not_a_notif_type = 'Value passed as an argument does not correspond' ..
		'to a valid Notification type. See Notification.type for a list' ..
		'of possible types'
}

-- all types of Notifications
Notification.Type.ERROR = class.new_instance(Notification.Type)
Notification.Type.TRACE = class.new_instance(Notification.Type)
Notification.Type.DEBUG = class.new_instance(Notification.Type)
Notification.Type.WARN = class.new_instance(Notification.Type)
Notification.Type.INFO = class.new_instance(Notification.Type)

-- correspondance between notification types and vim log levels
local notif_type_converter = {}
notif_type_converter[Notification.Type.ERROR] = vim.log.levels.ERROR
notif_type_converter[Notification.Type.TRACE] = vim.log.levels.TRACE
notif_type_converter[Notification.Type.DEBUG] = vim.log.levels.DEBUG
notif_type_converter[Notification.Type.WARN] = vim.log.levels.WARN
notif_type_converter[Notification.Type.INFO] = vim.log.levels.INFO

-- convertes notification type to vim log level
-- @param type (Notification.Type): the notification type
-- @return (vim.log.level): corresponding vim log level
function Notification.Type.to_log_level(type)
	-- makes sure that type is a notification type
	assert(class.is_instance(type, Notification.Type),
		Notification.Type.__error.not_a_notif_type)

	-- convertes the notification type back to a vim log level
	return notif_type_converter[type]
end

-- Creates a new instance of the Notification class
-- @param message_val (string): notification message, "" by default
-- @param title_val (string): title of the notification, "" by default
-- @param type_val (Notification.type): type of the notification,
-- Notification.type.info by default
-- @return new instance of Notification
Notification.new = function(message_val, title_val, type_val)
	-- sets parameters to defautls in case they are not specified
	message_val = message_val or ""
	title_val = title_val or ""
	type_val = type_val or Notification.Type.info

	-- checks the validity of the parameters passed to the function
	assert(type_val(message_val) == 'string',
		Notification.__error.not_a_message)
	assert(type_val(title_val) == 'string',
		Notification.__error.not_a_title)
	assert(class.is_instance(type_val, Notification.Type),
		Notification.Type.__error.not_a_notif_type)

	-- creates the notification
	local notification = {
		message = message_val,
		title = title_val,
		type = type_val
	}

	-- returns the notification
	return notification
end

return Notification
