extends InteractableTemplate
class_name Bush

onready var texture: Sprite = get_node("Texture")

const LEAVES: String = "res://scenes/effect/leaves_hit.tscn"

export(bool) var special_bush = false

func _ready() -> void:
	randomize()
	health = randi() % 15 + 5
	var duplicated_material: Material = texture.get_material().duplicate()
	texture.set_material(duplicated_material)
	
	
func update_health(_area: CharacterInteractableArea, damage: int) -> void:
	health -= damage
	if health <= 0:
		kill()
		
	animation.play("bush_hit")
	Globals.instance_object(LEAVES, global_position, null)
	
	
func kill() -> void:
	if special_bush:
		print("Spawn something!!!")
		
	queue_free()
