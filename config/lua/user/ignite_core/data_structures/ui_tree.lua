-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- ============================================================================
--									NODE
-- ============================================================================

-- represents a window in Nvim and the windows neighbouring it
local UI_Node = Class.new()

-- Node-related errors
UI_Node.add_error {
	not_a_depth = 'Node depth must be a number',
	not_a_node = 'table is not a Node but is treated as such',
	not_an_override = 'neighbour override must be a boolean',
	illegal_override = 'cannot override existing Node. Set override' ..
		'to true to allow for Node override'
}

-- node directions
UI_Node.Direction = Class.new()

-- Direction-related errors
UI_Node.Direction.add_error {
	not_a_direction = 'table is not a Node Direction but is treated as such' ..
		'. See UI_Node.Direction for a list of all Directions'
}

-- all node directions
UI_Node.Direction.TOP = Class.new_instance(UI_Node.Direction)
UI_Node.Direction.BOTTOM = Class.new_instance(UI_Node.Direction)
UI_Node.Direction.LEFT = Class.new_instance(UI_Node.Direction)
UI_Node.Direction.RIGHT = Class.new_instance(UI_Node.Direction)

-- Creates a new Node
-- @return (Node): a new node
UI_Node.new = function (
	node_depth,
	node_top,
	node_bottom,
	node_left,
	node_right
)
	-- makes sure function arguments are valid
	assert(type(node_depth) == 'number', UI_Node.__error.not_a_depth)
	assert(Class.is_instance(node_top, UI_Node), UI_Node.__error.not_a_node)
	assert(Class.is_instance(node_bottom, UI_Node), UI_Node.__error.not_a_node)
	assert(Class.is_instance(node_left, UI_Node), UI_Node.__error.not_a_node)
	assert(Class.is_instance(node_right, UI_Node), UI_Node.__error.not_a_node)

	-- the Node table
	local node = Class.new_instance(UI_Node)

	-- private fields
	node.add_private {
		depth = node_depth
	}

	-- populates node neighbours
	node[UI_Node.Direction.TOP] = node_top
	node[UI_Node.Direction.BOTTOM] = node_bottom
	node[UI_Node.Direction.LEFT] = node_left
	node[UI_Node.Direction.RIGHT] = node_right

	-- returns the new node
	return node
end

-- sets the depth of a Node
-- @param node (Node): the Node to set the depth of
-- @param depth (number): the depth to set the Node at
function UI_Node.set_depth(node, depth)
	-- makes sure function arguments are valid
	assert(Class.is_instance(node, UI_Node), UI_Node.__error.not_a_node)
	assert(type(depth) == 'number', UI_Node.__error.not_a_depth)

	-- sets the Node's depth
	node.__private.depth = depth
end

-- gets the depth of a Node
-- @param node (Node): the Node to set the depth of
-- @return (number): the depth of the Node
function UI_Node.get_depth(node)
	-- makes sure function arguments are valid
	assert(Class.is_instance(node, UI_Node), UI_Node.__error.not_a_node)

	-- gets the depth of the Node
	return node.__private.depth
end

-- adds a child Node to another Node
-- @param parent (Node): the Node to add the child to
-- @param child (Node): the Node to be added to the parent
-- @param override (boolean): if true, override existing neighbours, false by
-- default
-- @param Direction (Node.Direction): the Direction at which to place the Node
function UI_Node.add_child(parent, child, direction, override)
	-- sets defaults
	override = override or false

	-- makes sure function arguments are valid
	assert(Class.is_instance(parent, UI_Node), UI_Node.__error.not_a_node)
	assert(Class.is_instance(child, UI_Node), UI_Node.__error.not_a_node)
	assert(Class.is_instance(direction, UI_Node.Direction),
		UI_Node.Direction.__error.not_a_direction)
	assert(type(override) == 'boolean', UI_Node.__error.not_an_override)

	-- gets the current value of the Node's neighbour at the given direction
	local neighbour = parent[direction]

	-- if parent has no neighbour or override is set to true...
	if neighbour == nil or override then
		-- updates the depth of the child
		child.__private.depth = parent.__private.depth + 1

		-- sets the child node to be the parent Node's neighbour
		parent[direction] = child
	else
		-- if override is not permitted, throws an error
		error(UI_Node.__error.illegal_override)
	end
end

-- ============================================================================
--									TREE
-- ============================================================================

-- responsible for representing UI hierarchies in Ignite
local UI_Tree = Class.new()

-- Tree-related errors
UI_Tree.add_error {

}

UI_Tree.new = function ()
	-- tree table
	local tree = Class.new_instance(UI_Tree)
end

return UI_Tree
