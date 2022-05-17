extends Area2D
class_name InteractableTemplate

export(int) var health
export(Array, String, MULTILINE) var effective_tools

func on_area_entered(area: CharacterInteractableArea) -> void:
	for character_tool in effective_tools:
		if area.current_tool == character_tool:
			var tool_dict: Dictionary = area.tools_dict[character_tool]
			print(tool_dict)
