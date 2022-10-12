-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- ============================================================================
--									NODE
-- ============================================================================

-- represents a window in Nvim and the windows neighbouring it
local UI_Node = Class.new()

-- Node-related errors
UI_Node.add_error {
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
	node_top,
	node_bottom,
	node_left,
	node_right,
	value
)
	-- makes sure function arguments are valid
	assert(node_top == nil or Class.is_instance(node_top, UI_Node),
		UI_Node.__error.not_a_node)
	assert(node_bottom == nil or Class.is_instance(node_bottom, UI_Node),
		UI_Node.__error.not_a_node)
	assert(node_left == nil or Class.is_instance(node_left, UI_Node),
		UI_Node.__error.not_a_node)
	assert(node_right == nil or Class.is_instance(node_right, UI_Node),
		UI_Node.__error.not_a_node)

	-- the Node table
	local node = Class.new_instance(UI_Node)

	-- populates node neighbours
	node[UI_Node.Direction.TOP] = node_top
	node[UI_Node.Direction.BOTTOM] = node_bottom
	node[UI_Node.Direction.LEFT] = node_left
	node[UI_Node.Direction.RIGHT] = node_right

	-- sets node value
	node.value = value

	-- returns the new node
	return node
end

-- gets the value associated to a Node
-- @param node (Node): the Node to get the value of
-- @return (any): the Node's value
function UI_Node.get_value(node)
	-- makes sure function arguments are valid
	assert(Class.is_instance(node, UI_Node), UI_Node.__error.not_a_node)

	-- gets the node's value
	return node.value
end

-- sets the value associated to a node
-- @param node (Node): the Node to set the value of
-- @param value (any): the value to set the Node at
function UI_Node.set_value(node, value)
	-- makes sure function arguments are valid
	assert(Class.is_instance(node, UI_Node), UI_Node.__error.not_a_node)

	--  sets the Node's value
	node.value = value
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
		-- sets the child node to be the parent Node's neighbour
		parent[direction] = child
	else
		-- if override is not permitted, throws an error
		error(UI_Node.__error.illegal_override)
	end
end

-- determines if a node has children
-- @param node (Node): the Node to check
-- @return (boolean): true if the node has children, false otherwise
function UI_Node.has_children(node)
	-- makes sure function arguments are valid
	assert(Class.is_instance(node, UI_Node), UI_Node.__error.not_a_node)

	-- determines if the node has children
	return node[UI_Node.Direction.TOP] or node[UI_Node.Direction.BOTTOM]
		or node[UI_Node.Direction.LEFT] or node[UI_Node.Direction.RIGHT]
end

-- defines node priority in accessing / removing
UI_Node.priority = {
	UI_Node.Direction.TOP,
	UI_Node.Direction.BOTTOM,
	UI_Node.Direction.LEFT,
	UI_Node.Direction.RIGHT
}

--gets the child of a Node witht the highest priority
--@param node (UI_Node): the node to inspect
--@return (UI_Node): the UI_Node's child with the highest priority, or nil if
--the node has no children
function UI_Node.get_by_priority(node)
	-- makes sure function arguments are valid
	assert(Class.is_instance(node, UI_Node), UI_Node.__error.not_a_node)

	local child

	-- iterates over every child in the parent UI_Node in their order of 
	-- priority...
	for _, value in ipairs(UI_Node.priority) do
		-- ...and stops at the first valid child found
		if node[value] then
			child = node[value]
		end
	end

	-- returns the child with the highest priority. If no child was found, 
	-- returns nil
	return child
end

--swaps a node with its highest priority child (HPC). HPC inherits all other
--children from the original node
--@param node (UI_Node): the node to replace
--@return (UI_Node): HPC with updated children
function UI_Node.swap_by_priority(node)
	-- makes sure function arguments are valid
	assert(Class.is_instance(node, UI_Node), UI_Node.__error.not_a_node)

	-- gets the node's highest priority child
	local hpc = UI_Node.get_by_priority(node)

	-- for every children in the node...
	for _, direction in ipairs(UI_Node.priority) do
		-- ...if the current child is the hpc...
		if node[direction] == hpc then
			-- ...ignores it
			goto continue
		end

		-- adds the current node to the hpc
		hpc[direction] = node[direction]

		-- moves on to the next iteration of the loop
		::continue::
	end

	-- returns the hpc with updated children
	return hpc
end

return UI_Node
