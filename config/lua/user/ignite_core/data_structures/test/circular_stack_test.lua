-- dependencies
local Circ_Stack = require 'user.ignite_core.data_structures.circular_stack'
local Notification = require 'user.ignite_core.data_structures.notification'
local ignite_notify = require 'user.ignite_core.ignite_notify'

local stack = Circ_Stack.new({0, 1, 2, 3}, 4)
Circ_Stack.push_head(stack, 4)
Circ_Stack.push_head(stack, 5)

ignite_notify.notify(Notification.new(
	tostring(Circ_Stack.poll_head(stack)),
	'Debug',
	Notification.Type.INFO
))

ignite_notify.notify(Notification.new(
	 tostring(stack),
	'Debug',
	Notification.Type.INFO
))
