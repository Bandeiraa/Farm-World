extends InteractableTemplate
class_name NormalBush

const LEAVES: String = "res://scenes/effect/leaves_hit.tscn"

func _ready() -> void:
	randomize()
	health = randi() % 15 + 5
	
	
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()
		
	animation.play("bush_hit")
	Globals.instance_object(LEAVES, global_position)