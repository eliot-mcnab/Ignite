-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'
local Class = require 'user.ignite_core.ignite_classes'

-- responsible for handling UI in Ignite
local ignite_ui = {}

-- represents the state of the UI
local UI_State = Class.new()

UI_State.VISIBLE = Class.new_instance(UI_State)
UI_State.HIDDEN = Class.new_instance(UI_State)
UI_State.ERROR = Class.new_instance(UI_State)

-- saves the state of the UI. By default, UI is hidden
ignite_ui.state = UI_State.HIDDEN

-- represents UI components that can be displayed
local UI_Component = Class.new()

UI_Component.TREE = Class.new_instance(UI_Component)
UI_Component.DIAGNOSTICS = Class.new_instance(UI_Component)
UI_Component.TERMINAL = Class.new_instance(UI_Component)

return ignite_ui
