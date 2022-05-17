extends Area2D
class_name InteractableTemplate

onready var animation: AnimationPlayer = get_node("Animation")

export(int) var health
export(Array, Array, String) var effective_tools

func on_area_entered(area: CharacterInteractableArea) -> void:
	for character_tool in effective_tools:
		var current_tool: String = character_tool[0]
		var tool_damage: int = int(character_tool[1])
		if area.current_tool == current_tool:
			update_health(tool_damage)
			
			
func update_health(_damage: int) -> void:
	pass
