extends Area2D
class_name CharacterInteractableArea

var current_tool: String = ""
var tools_dict: Dictionary = {
	"Axe": {
		"damage": 3
	},
	
	"Mine": {
		"damage": 1
	},
	
	"Dig": {
		"damage": 0
	},
	
	"Attack": {
		"damage": 5
	}
}
