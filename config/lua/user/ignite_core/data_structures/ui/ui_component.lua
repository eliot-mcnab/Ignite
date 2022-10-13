-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- represents a UI Component used by Ignite. UI Components are UI elements that
-- are provided in seperate plugins. Ignite handles their display logic to
-- ensure a consistent UI
local Component = Class.new()

-- Component-related errors
Component.add_error {
	not_a_component = 'table is not a Component but is treated as such.'  ..
		'Available Components are: TREE, DIAGNOSTICS and TERMINAL.',
	no_a_draw_function = 'Component draw_function must be a function',
	not_a_erase_function = 'Component erase_function must be a function'
}

-- private constructor for new Components
-- @param draw_function (function()): the function called to display the
-- component
-- @param erase_function (function()): the function called to remove the
-- component
-- @return (Component): new Component instance
local function new_component(draw_function, erase_function)
	-- makes sure function arguments are valid
	assert(type(draw_function) == 'function')
	assert(type(erase_function) == 'function')

	-- the new Component instance
	local component = Class.new_instance(Component)

	-- sets the Component's draw and erase functions
	component.draw = draw_function
	component.erase = erase_function

	-- returns the new component
	return component
end
-- all Components available to Ignite

-- Tree Component, handled by NvimTree
Component.TREE = new_component(
	function ()
		vim.cmd [[NvimTreeOpen]]
	end,
	function ()
		vim.cmd [[NvimTreeClose]]
	end
)

-- Diagnostics Component, handled by Trouble
Component.DIAGNOSTICS = new_component(
	function ()
		vim.cmd [[Trouble]]
	end,
	function ()
		vim.cmd [[TroubleClose]]
	end
)

-- Terminal Component, handled by ToggleTerm
Component.TERMINAL = new_component(
	function ()
		vim.cmd [[ToggleTerm]]
	end,
	function ()
		vim.cmd [[ToggleTerm]]
	end
)

-- calls the draw() function for a Component
-- @param component (Component): the Component to draw
function Component.draw(component)
	-- makes sure that function arguments are valid
	assert(Class.is_instance(component, Component),
		Component.__error.not_a_component)

	-- calls the Component's draw() function
	component.draw()
end

-- calls the  erase() function for a Component
-- @param component (Component): the Component to erase
function Component.erase(component)
	-- makes sure function arguments are valid
	assert(Class.is_instance(component, Component),
		Component.__error.not_a_component)

	-- calls the Component's erase() function
	component.erase()
end

return Component
