-- dependencies
local Class = require 'user.ignite_core.ignite_classes'
local ignite_terminal = require 'user.ignite_core.ignite_terminal'

-- represents a UI Component used by Ignite. UI Components are UI elements that
-- are provided in seperate plugins. Ignite handles their display logic to
-- ensure a consistent UI
local Component = Class.new()

Component.add_private('is_drawn', false)
Component.add_private('draw', nil)
Component.add_private('erase', nil)
Component.add_private('name', nil)

-- Component-related errors
Component.add_error {
	not_a_component = 'table is not a Component but is treated as such.'  ..
		'Available Components are: TREE, DIAGNOSTICS and TERMINAL.',
	no_a_draw_function = 'Component draw_function must be a function',
	not_a_erase_function = 'Component erase_function must be a function'
}

-- ============================================================================
--									CONSTRUCTOR
-- ============================================================================

-- private constructor for new Components
-- @param draw_function (function()): the function called to display the
-- component
-- @param erase_function (function()): the function called to remove the
-- component
-- @param name (string): the name of the component, used for serialisation
-- @return (Component): new Component instance
local function new_component(draw_function, erase_function, name)
	-- makes sure function arguments are valid
	assert(type(draw_function)  == 'function')
	assert(type(erase_function) == 'function')
	assert(type(name)           == 'string')

	-- the new Component instance
	local component = Class.new_instance(Component)

	-- sets private fields
	component.__private.draw  = draw_function
	component.__private.erase = erase_function
	component.__private.name  = name

	-- returns the new component
	return component
end

-- ============================================================================
--									COMPONENTS
-- ============================================================================

-- Tree Component, handled by NvimTree
Component.FILE_TREE = new_component(
	function ()
		vim.cmd [[NvimTreeOpen]]
	end,
	function ()
		vim.cmd [[NvimTreeClose]]
	end,
	'FILE_TREE'
)

-- Diagnostics Component, handled by Trouble
Component.DIAGNOSTICS = new_component(
	function ()
		vim.cmd [[Trouble]]
	end,
	function ()
		vim.cmd [[TroubleClose]]
	end,
	'DIAGNOSTICS'
)

-- Terminal Component, handled by ToggleTerm
Component.TERMINAL = new_component(
	function ()
		ignite_terminal.default:toggle()	-- opens the terminal
	end,
	function ()
		ignite_terminal.default:shutdown()
	end,
	'TERMINAL'
)

-- Symbols Component, handled by Symbols-Outline
Component.SYMBOLS = new_component(
	function ()
		vim.cmd [[SymbolsOutline]]
	end,
	function ()
		vim.cmd [[SymbolsOutline]]
	end,
	'SYMBOLS'
)

-- non-nil representation of an absent component
Component.NONE = new_component(
	function ()	end,
	function ()	end,
	'NONE'
)

-- calls the draw() function for a Component
-- @param component (Component): the Component to draw
function Component.draw(component)
	-- makes sure that function arguments are valid
	assert(Class.is_instance(component, Component),
		Component.__error.not_a_component)

	-- calls the Component's draw() function
	component.__private.draw()

	-- updates the Component's state
	component.__private.is_drawn = true
end

-- calls the  erase() function for a Component
-- @param component (Component): the Component to erase
function Component.erase(component)
	-- makes sure function arguments are valid
	assert(Class.is_instance(component, Component),
		Component.__error.not_a_component)

	-- calls the Component's erase() function
	component.__private.erase()

	-- updates the Component's state
	component.__private.is_drawn = false
end

-- determines if a Component is currently being drawn
-- @param component (Component): the Component to check
-- @return (boolean): true if the Component is being drawn, false otherwise
function Component.is_drawn(component)
	-- makes sure function arguments are valid
	assert(Class.is_instance(component, Component),
		Component.__error.not_a_component)

	-- determines if the Component is being drawn
	return component.__private.is_drawn
end

return Component
