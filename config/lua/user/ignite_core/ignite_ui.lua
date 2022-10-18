local Slot = require 'user.ignite_core.data_structures.ui.ui_slots'
local Component = require 'user.ignite_core.data_structures.ui.ui_component'
local Class = require 'user.ignite_core.ignite_classes'

-- debugging
local ignite_notify = require 'user.ignite_core.ignite_notify'
local Notification = require 'user.ignite_core.data_structures.notification'

-- responsible for displaying the UI to the user and handling the interaction
-- between various UI plugins
local ignite_ui = {}

-- stores the state of the UI. By default UI is inactive
ignite_ui.is_active = false

-- a table of all Slots in the order in which they must be drawn
local draw_order = {
	Slot.INFO_PANEL,
	Slot.R_MENU,
	Slot.L_MENU,
	Slot.T_MENU
}

-- number of Components kept in memory by a Slot (basically the hist)

-- associated default UI components to their Slots
Slot.set_fallback(Slot.T_MENU, Component.NONE)
Slot.set_fallback(Slot.R_MENU, Component.NONE)
Slot.set_fallback(Slot.L_MENU, Component.NONE)
Slot.set_fallback(Slot.INFO_PANEL, Component.NONE)

-- correspondance between Component and their allowed Slots
local slot_correspondance = {}
slot_correspondance[Component.DIAGNOSTICS] = Slot.INFO_PANEL
slot_correspondance[Component.TERMINAL] = Slot.INFO_PANEL
slot_correspondance[Component.FILE_TREE] = Slot.L_MENU
slot_correspondance[Component.SYMBOLS] = Slot.R_MENU

-- correspondance between Slot and the command used to move curso to main 
-- buffer
local return_to_center = {}
return_to_center[Slot.INFO_PANEL] = [[wincmd k]]
return_to_center[Slot.R_MENU] = [[wincmd h]]
return_to_center[Slot.L_MENU] = [[wincmd l]]
return_to_center[Slot.T_MENU] = [[wincmd j]]

-- resets UI to default layout
--
-- Default Ignite layout:
-- +----------------------------------------+
-- |				   NONE				    |
-- +----------------------------------------+
-- |		|						|		|	
-- |		|						|		|
-- |  FILE  |						|  NONE |
-- |  TREE  |						|		|
-- |		|						|		|
-- |		|						|		|
-- |		+-----------------------+		|
-- |		|	 LSP DIAGNOSTICS	|		|
-- +--------+-----------------------+-------+
function ignite_ui.defaults()
	-- flushes history for all Slots
	Slot.flush_history(Slot.T_MENU)
	Slot.flush_history(Slot.L_MENU)
	Slot.flush_history(Slot.R_MENU)
	Slot.flush_history(Slot.INFO_PANEL)

	-- sets Info Panel to contain LSP Diagnostics
	Slot.set_component(Slot.INFO_PANEL, Component.DIAGNOSTICS)
	-- sets Left Menu to contain File Tree
	Slot.set_component(Slot.L_MENU, Component.FILE_TREE)
end

-- resets the UI by removing all Components associated to every Slot
function ignite_ui.reset()
	-- for every slot (unordered)...
	for _, slot in pairs(slot_correspondance) do
		-- ... removes its component
 		local component = Slot.remove_component(slot)
		-- ... and erases it from the UI if the ui is being displayed
		if ignite_ui.is_active then
			Component.erase(component)
		end
	end
end

-- Draws the UI as specified by each Slot
function ignite_ui.draw_ui()
	-- for every slot...
	for _, slot in ipairs(draw_order) do
		-- gets the component stored in that Slot
		local component = Slot.get_component(slot)

		-- if the component is empty, ignores the Slot
		if not component then
			goto continue
		end

		-- draws the component onto the UI
		Component.draw(component)

		-- returns to the original buffer
		vim.cmd(return_to_center[slot])

		::continue::
	end

	-- updates the state of the UI
	ignite_ui.is_active = true
end

-- Erases the UI as specified by each slot
function ignite_ui.erase_ui()
	-- for every slot (unordered)...
	for _, slot in pairs(draw_order) do
		-- gets the component stored by that slot
		local component = Slot.get_component(slot)

		-- if the component is empty, ignores the Slot
		if not component then
			goto continue
		end

		-- erases the component from the UI
		Component.erase(component)

		::continue::
	end

	-- updates the state of the UI
	ignite_ui.is_active = false
end

-- redraws the UI
function ignite_ui.redraw()
	-- erases the current UI
	ignite_ui.erase_ui()

	-- redraws the UI
	ignite_ui.draw_ui()
end

-- toggles a Component in the UI
-- @param component (Component): the Component to toggle. Component placement
-- is provided by slot_correspondance table and cannot be edited
function ignite_ui.toggle_component(component)
	-- makes sure function arguments are valid
	assert(Class.is_instance(component, Component),
		Component.__error.not_a_component)

	-- if the UI is not displaying...
	if not ignite_ui.is_active then
		-- ... resets it
		ignite_ui.reset()
	end

	-- gets the Slot associated to the Component
	local slot = slot_correspondance[component]

	-- saves current UI state
	local was_active = ignite_ui.is_active

	-- erases the UI
	ignite_ui.erase_ui()

	-- if the component is already present in the Slot...
	if was_active and (Slot.get_component(slot) == component) then
		-- ... removes the component from its current slot
		Slot.remove_component(slot)
	else
		-- updates the Slot's component
		Slot.set_component(slot, component)
	end

	-- draws the UI with the new Component
	ignite_ui.draw_ui()
end

-- sets up UI for use
function ignite_ui.setup()
	-- resets the UI to default
	-- TODO: in the future could load previous UI so user preference can 
	-- persist throughout sessions

	-- creates command for toggling the UI
	vim.api.nvim_create_user_command(
		'UIToggle',
		function ()
			if ignite_ui.is_active then
				ignite_ui.erase_ui()
			else
				ignite_ui.defaults()
				ignite_ui.draw_ui()
			end
		end,
		{
			bang = true,
			desc = 'Toggles Ignite UI'
		}
	)
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
