extends RigidBody2D
class_name CollectableTemplate

onready var impulse_timer: Timer = get_node("ImpulseTimer")

var additional_argument: Vector2 = Vector2.ZERO

export(float) var impulse_wait_time = 0.5
export(bool) var can_apply_impulse = false

func _ready() -> void:
	randomize()
	if not can_apply_impulse:
		return
		
	apply_impulse(
		Vector2.ZERO,
		Vector2(
			rand_range(30, 90) * additional_argument.x,
			rand_range(30, 90) * additional_argument.y
		)
	)
	
	impulse_timer.start(impulse_wait_time)
	
	
func on_impulse_timer_timeout() -> void:
	sleeping = true
	
	
func on_collectable_area_body_entered(_body: CharacterBase) -> void:
	pass
	
	
func on_screen_exited():
	queue_free()
