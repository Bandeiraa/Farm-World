extends InteractableTemplate

const LEAVES: String = "res://scenes/effect/leaves_hit.tscn"
const TRUNK: String = "res://scenes/collectable/trunk.tscn"

onready var tree_texture: Sprite = get_node("Texture")
onready var timer: Timer = get_node("GrowthTimer")

var base_texture: String
var base_texture_list: Array = [
	"res://assets/interactable/tree/base/base_type_1.png",
	"res://assets/interactable/tree/base/base_type_2.png"
]

var trunk: String = "res://assets/interactable/tree/trunk/trunk.png"
var full_tree: String = "res://assets/interactable/tree/tree.png"

var current_state: int = 0

export(Array, float) var growth_timer
export(Array, Vector2) var tree_position

func _ready() -> void:
	initial_configuration()
	
	
func initial_configuration() -> void:
	randomize()
	
	var duplicated_material: Material = tree_texture.get_material().duplicate()
	tree_texture.set_material(duplicated_material)
	
	var random_number: int = randi() % base_texture_list.size()
	base_texture = base_texture_list[random_number]
	var initial_state: int = randi() % 3
	current_state = initial_state
	match_state(initial_state)
	
	
func match_state(state: int) -> void:
	match state:
		0:
			initial_state()
			
		1:
			middle_state()
			
		2: 
			final_state()
			
			
func initial_state() -> void:
	current_state = 0
	health = randi() % 15 + 5
	tree_texture.position = Vector2.ZERO
	tree_texture.texture = load(base_texture)
	timer.start(growth_timer[current_state])
	
	
func middle_state() -> void:
	health = randi() % 15 + 15
	tree_texture.texture = load(trunk)
	timer.start(growth_timer[current_state])
	tree_texture.position = tree_position[current_state - 1]
	
	
func final_state() -> void:
	health = randi() % 15 + 30
	tree_texture.texture = load(full_tree)
	tree_texture.position = tree_position[current_state - 1]
	
	
func update_health(area: CharacterInteractableArea, damage: int) -> void:
	if current_state != 0:
		health -= damage
		if health <= 0:
			var direction: Vector2 = (global_position - area.owner.global_position).normalized()
			match current_state:
				1:
					spawn_resources(randi() % current_state + 1, direction)
					
				2:
					spawn_resources(randi() % current_state + 1, direction)
					
			initial_state()
			
		animation.play("tree_hit")
		Globals.instance_object(LEAVES, global_position, null)
		
		
func on_growth_timer_timeout() -> void:
	current_state += 1
	match_state(current_state)
	
	
func spawn_resources(amount: int, player_direction: Vector2) -> void:
	for resource in amount:
		Globals.instance_object(TRUNK, global_position, player_direction)
