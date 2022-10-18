-- dependencies
local Class = require 'user.ignite_core.ignite_classes'
local Component = require 'user.ignite_core.data_structures.ui.ui_component'
local Circ_Stack = require 'user.ignite_core.data_structures.circular_stack'

-- a Slot is a container for a UI Stack, which allows to Slot to have store a
-- history of the Components it displayed. Ignite defines a set amount of
-- Slots which can be used to display Components, without the ability to add
-- new Slots for the time being, thought that is a goal for ruther down along
-- development
local Slot = Class.new()

-- Slot-related errors
Slot.add_error {
	not_a_slot = 'table is not a Slot but is treated as such' ..
		'Available Slots are: T_MENU, L_MENU, R_MENU and INFO_PANEL',
	not_a_depth = 'Slot history depth must be a number.'
}

-- private Slot constructor
-- @return (Slot): new Slot instance
local function new_slot()
	-- the new Slot instace
	local slot = Class.new_instance(Slot)

	-- initialises the slot's Component Stack
	slot.add_private {
		components = Circ_Stack.new()
	}

	-- returns the new Slot instance
	return slot
end

-- Slots provided by Ignite:
-- +----------------------------------------+
-- |				TOP MENU				|
-- +----------------------------------------+
-- |		|						|		|
-- |		|						|		|
-- |  LEFT  |						| RIGHT |
-- |  MENU  |						|  MENU |
-- |		|						|		|
-- |		|						|		|
-- |		+-----------------------+		|
-- |		|		INFO PANEL		|		|
-- +--------+-----------------------+-------+
Slot.T_MENU = new_slot()
Slot.L_MENU = new_slot()
Slot.R_MENU = new_slot()
Slot.INFO_PANEL = new_slot()

-- sets the maximum number of Component kept in memory by a Slot
-- @param slot (Slot): the Slot to set
-- @param history_depth (number): max number of Components remembered by the
-- Slot
function Slot.set_history_depth(slot, history_depth)
	-- makes sure function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)
	assert(type(history_depth) == 'number', Slot.__error.not_a_depth)

	-- sets the Slot's max number of Components in memory
	Circ_Stack.set_max_size(slot.__private.components, history_depth)
end

-- gets the maximum number of Component kept in memory by a Slot
-- @param slot (Slot): the Slot from which to get the history_depth
-- @return (number): the history_depth associated to a Slot
function Slot.get_history_depth(slot, history_depth)
	-- makes sure function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)
	assert(type(history_depth) == 'number', Slot.__error.not_a_depth)

	-- gets the Slot's max possibme number of Components in memory
 	return Circ_Stack.get_max_size(slot.__private.components)
end

-- removes all Components stored in a Slot's Component Stack
-- @param slot (Slot): the Slot for which to remove all Components
function Slot.flush_history(slot)
	-- makes sure function arguments are valid
	assert(Class.is_instance(slot, Slot),
		Slot.__error.not_a_slot)

	-- flushes the Slot's history
	Circ_Stack.flush(slot.__private.components)
end

-- sets fallback Component for a Slot if it has no Component in its Stack
-- @param slot (Slot): the Slot to the set the fallback of
-- @param fallback (Component): the fallback Component
function Slot.set_fallback(slot, fallback)
	-- makes sure function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)
	assert(Class.is_instance(fallback, Component),
		Component.__error.not_a_component)

	-- sets Slot Stack fallback
	Circ_Stack.set_fallback(slot.__private.components, fallback)
end

-- gets fallback Component associated to a Slot
-- @param slot (Slot): the Slot to get the fallback from
-- @return (Component): fallback Component associated to a Slot
function Slot.get_fallback(slot, fallback)
	-- makes sure function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)
	assert(Class.is_instance(fallback, Component),
		Component.__error.not_a_component)

	-- gets Slot Stack fallback
	return Circ_Stack.get_fallbacket_fallback(slot.__private.components)
end

-- Disassociates the component which is currently at the head of the a Slot's
-- Component Stack
-- @param slot (Slot): the Slot from which to remove the Component
-- @return (Component): the Component attached to this slot, or nil if no
-- component was attached
function Slot.remove_component(slot)
	-- makes sure function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)

	-- gest the Component currently associated to the Slot
	local component = Circ_Stack.poll_head(slot.__private.components)

	-- erases the Component from the UI
	Component.erase(component)

	-- returns the component that was associated to the slot
	return component
end

-- Adds new Component to Slot Component Stack. If Slot already has a Component 
-- associated to it, removes it from the UI by calling its erase() function
-- @param slot (Slot): the Slot to set the component of
-- @param component (Component): the Component to set inside of the Slot
function Slot.set_component(slot, component_new)
	-- makes sure that the function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)
	assert(Class.is_instance(component_new, Component),
		Component.__error.not_a_component)

	-- gets the slot's current component
	local component = Circ_Stack.peek_head(slot.__private.components)

	-- if the slot already had a component associated to it...
	if component then
		-- ... calls its erase() function to remove it from the UI
		Component.erase(component)
	end

	-- sets the Slot's Component
	Circ_Stack.push_head(slot.__private.components, component_new)
end

-- Gets the Component attached to a Slot
-- @param slot (Slot): the Slot containing the Component
-- @return (Component): the Component contained by the Slot, or nil if the Slot
-- does not have any Component associated to it
function Slot.get_component(slot)
	-- makes sure that the function arguments are valid
	assert(Class.is_instance(slot, Slot))

	-- gets the Component associated to the Slot
	return Circ_Stack.peek_head(slot.__private.components)
end

return Slot
