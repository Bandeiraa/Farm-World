extends KinematicBody2D
class_name CharacterBase

onready var body: Node2D = get_node("Body")

var velocity: Vector2
var is_sprint: bool = false

export(int) var speed

func _physics_process(_delta: float) -> void:
	move()
	body.animate()
	
	
func move() -> void:
	var direction: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	velocity = direction * speed * sprint()
	velocity = move_and_slide(velocity)
	
	
func sprint() -> float:
	if Input.is_action_pressed("sprint"):
		is_sprint = true
		return 1.5
		
	is_sprint = false
	return 1.0
