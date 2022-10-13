-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'
local Class =  require 'user.ignite_core.ignite_classes'
local Slot = require 'user.ignite_core.data_structures.ui.ui_slots'
local Component = require 'user.ignite_core.data_structures.ui.ui_component'

-- responsible for displaying the UI to the user and handling the interaction
-- between various UI plugins
local ignite_ui = {}

-- a table of all Slots in the order in which they must be drawn
local draw_order = {
	Slot.INFO_PANEL,
	Slot.L_MENU,
	Slot.R_MENU,
	Slot.T_MENU
}

-- Draws the UI as specified by each Slot
function ignite_ui.draw_ui()
	-- for every slot...
	for slot, _ in ipairs(draw_order) do
		-- gets the component stored in that Slot
		local component = Slot.get_component(slot)

		-- if the component is empty, ignores the Slot
		if not component then
			goto continue
		end

		::continue::
	end
end

return ignite_ui

-- dependencies
--local plugins = require 'user.ignite_core.ignite_plugins'
--local Class = require 'user.ignite_core.ignite_classes'
--local Node = require 'user.ignite_core.data_structures.ui.ui_tree'

---- responsible for handling UI in Ignite
--local ignite_ui = {}

---- ============================================================================
----									UI STATES
---- ============================================================================

---- represents the state of the UI
--local UI_State = Class.new()

---- State-related errors
--UI_State.add_error {
	--not_a_state = 'table is not a UI_State but is treated as such.' ..
		--'Valid UI_States are VISIBLE, HIDDEN and ERROR.'
--}

--UI_State.VISIBLE = Class.new_instance(UI_State)
--UI_State.HIDDEN = Class.new_instance(UI_State)
--UI_State.ERROR = Class.new_instance(UI_State)

---- saves the state of the UI. By default, UI is hidden
--ignite_ui.state = UI_State.HIDDEN

---- ============================================================================
----									UI COMPONENTS
---- ============================================================================

---- represents UI components that can be displayed
--local UI_Component = Class.new()

---- Component-related errors
--UI_Component.add_error {
	--not_a_component = 'table is not a UI_Component but is treated as such.' ..
		--'Valid UI_Components are TREE, DIAGNOSTICS, and TERMINAL.'
--}

--UI_Component.TREE = Class.new_instance(UI_Component)
--UI_Component.DIAGNOSTICS = Class.new_instance(UI_Component)
--UI_Component.TERMINAL = Class.new_instance(UI_Component)

---- ============================================================================
----									UI HANDLING
---- ============================================================================

---- ui root
--ignite_ui.root = Node.new()

---- maps UI Coponents to their position in the UI
--local ui_placements = {}
--ui_placements[UI_Component.TREE] = Node.Direction.LEFT
--ui_placements[UI_Component.DIAGNOSTICS] = Node.Direction.BOTTOM
--ui_placements[UI_Component.TERMINAL] = Node.Direction.BOTTOM

---- TODO: get this working
---- where to add new nodes in the child hierarchy if there is no space left
---- ex: bottom is already used, so we try and place new node to the right of the
---- this is not currently supported but is a note for future development
--local SPREAD = Node.Direction.RIGHT

---- adds component to UI tree
---- @param component (UI_Component): the component to add
---- @param direction (UI_Node.Direction): where to place the component
--function ignite_ui.place_component(component, direction)
	---- makes sure function arguments are valid
	--assert(Class.is_instance(component, UI_Component),
		--UI_Component.__error.not_a_component)
	--assert(Class.is_instance(direction, Node.Direction),
		--Node.Direction.__error.not_a_direction)

	---- gest the component in the UI tree
	--local direction_node = ignite_ui.root[direction]

	---- if component already exists...
	--if direction_node == component then
		---- ...replaces it by the child with the highest priority
		--ignite_ui.root[direction] = Node.swap_by_priority(direction_node)

		---- exists function
		--return
	--end

	---- if there is no space left for component...
	--if direction_node ~= component then
		---- ...traverses the UI Tree until we find a node whose SPREAD direction
		---- is empty
		--while direction_node[SPREAD] do
			--direction_node = direction_node[SPREAD]
		--end

		---- ...adds the component as child of the resulting node
		--local child = Node.new()
		--Node.set_value(child, component)

		--direction_node[SPREAD] = child

		---- exists function
		--return
	--end

	---- if there is space for the component...
	--if direction_node == nil then
		---- ...adds the component as child at the root of the ui tree
		--local child = Node.new()
		--Node.set_value(child, component)

		--ignite_ui.root[direction] = child

		---- exists the function
		--return
	--end
--end

--return ignite_ui
