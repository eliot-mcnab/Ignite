-- dependencies
local Class = require 'user.ignite_core.ignite_classes'
local Component = require 'user.ignite_core.data_structures.ui.ui_component'

-- a Slot is a container for a UI Component. Ignite defines a set amount of
-- slots which can be used to display components, without the ability to add
-- new Slots for the time being, thought that is a goal for ruther down along
-- development
local Slot = Class.new()

-- Slot-related errors
Slot.add_error {
	not_a_slot = 'table is not a Slot but is treated as such' ..
		'Available Slots are: T_MENU, L_MENU, R_MENU and INFO_PANEL'
}

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
Slot.T_MENU = Class.new_instance(Slot)
Slot.L_MENU = Class.new_instance(Slot)
Slot.R_MENU = Class.new_instance(Slot)
Slot.INFO_PANEL = Class.new_instance(Slot)

-- Disassociates the component which was currently attached to a Slot
-- @param slot (Slot): the Slot from which to remove the Component
-- @return (Component): the Component attached to this slot, or nil if no
-- component was attached
function Slot.remove_component(slot)
	-- makes sure function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)

	-- gets the current slot Component
	local component = slot.component

	-- if the Slot had a Component associated to it...
	if component then
		-- ... disassociates it from the Slot
		slot.component = nil
	end

	-- returns the component that was associated to the slot
	return component
end

-- Sets the Component inside of a Slot. If Slot already has a Component 
-- associated to it, removes it from the UI by calling its erase() function
-- @param slot (Slot): the Slot to set the component of
-- @param component (Component): the Component to set inside of the Slot
function Slot.set_component(slot, component)
	-- makes sure that the function arguments are valid
	assert(Class.is_instance(slot, Slot), Slot.__error.not_a_slot)
	assert(Class.is_instance(component, Component),
		Component.__error.not_a_component)

	-- if the slot already had a component associated to it...
	if slot.component then
		-- ... calls its erase() function to remove it from the UI
		Component.erase(slot.component)
	end

	-- sets the Slot's Component
	slot.component = component
end

-- Gets the Component attached to a Slot
-- @param slot (Slot): the Slot containing the Component
-- @return (Component): the Component contained by the Slot, or nil if the Slot
-- does not have any Component associated to it
function Slot.get_component(slot)
	-- makes sure that the function arguments are valid
	assert(Class.is_instance(slot, Slot))

	-- gets the Component associated to the Slot
	return slot.component
end

return Slot
