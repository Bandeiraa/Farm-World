extends InteractableTemplate
class_name NormalBush

onready var texture: Sprite = get_node("Texture")

const LEAVES: String = "res://scenes/effect/leaves_hit.tscn"

func _ready() -> void:
	randomize()
	health = randi() % 15 + 5
	var duplicated_material: Material = texture.get_material().duplicate()
	texture.set_material(duplicated_material)
	
	
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()
		
	animation.play("bush_hit")
	Globals.instance_object(LEAVES, global_position)
