extends KinematicBody2D
class_name CharacterBase

onready var body: Node2D = get_node("Body")
onready var tool_timer: Timer = get_node("ToolTimer")
onready var interaction_ray: RayCast2D = get_node("InteractionRay")

var velocity: Vector2

var on_action: bool = false

var is_axing: bool = false
var is_mining: bool = false
var is_digging: bool = false
var is_sprinting: bool = false
var is_attacking: bool = false

export(int) var speed

export(NodePath) onready var terrain = get_node(terrain) as Node2D

func _physics_process(_delta: float) -> void:
	move()
	action()
	body.animate()
	
	
func move() -> void:
	var direction: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	if direction != Vector2.ZERO:
		interaction_ray.cast_to = direction * GlobalData.GRID_SIZE/2
		
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
		if Input.is_action_just_pressed("attacking") and not is_attacking:
			action_state("Attacking", 1.0)
			
		elif Input.is_action_just_pressed("dig") and not is_digging and can_dig():
			action_state("Digging", 1.3)
			
		elif Input.is_action_just_pressed("axe") and not is_axing:
			action_state("Axing", 1.0)
			
		elif Input.is_action_just_pressed("mining") and not is_mining:
			action_state("Mining", 1.0)
			
			
func action_state(state: String, state_time: float) -> void:
	tool_timer.start(state_time)
	match state:
		"Attacking":
			is_attacking = true
			
		"Digging":
			is_digging = true
			
		"Axing":
			is_axing = true
			
		"Mining":
			is_mining = true
			
	on_action = true
	set_physics_process(false)
	
	
func on_tool_timer_timeout() -> void:
	on_action = false
	set_physics_process(true)
	
	
func can_dig() -> bool:
	var player_grid_position: Vector2 = (position + interaction_ray.cast_to)/GlobalData.GRID_SIZE
	var normalized_grid_position: Vector2 = Vector2(
		round(player_grid_position.x),
		round(player_grid_position.y)
	)
	
	if terrain.sand_tiles_list.has(normalized_grid_position):
		return true
		
	return false
