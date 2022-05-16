extends KinematicBody2D
class_name CharacterBase

onready var body: Node2D = get_node("Body")

var velocity: Vector2

var on_action: bool = false

var is_axing: bool = false
var is_mining: bool = false
var is_digging: bool = false
var is_sprinting: bool = false

export(int) var speed

func _physics_process(_delta: float) -> void:
	move()
	action()
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
		is_sprinting = true
		return 1.5
		
	is_sprinting = false
	return 1.0
	
	
func action() -> void:
	if not on_action:
		if Input.is_action_just_pressed("dig") and not is_digging:
			is_digging = true
			
		elif Input.is_action_just_pressed("axe") and not is_axing:
			is_axing = true
			
		elif Input.is_action_just_pressed("mining") and not is_mining:
			is_mining = true
