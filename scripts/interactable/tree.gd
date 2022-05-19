extends InteractableTemplate

const LEAVES: String = "res://scenes/effect/leaves_hit.tscn"

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
	health = randi() % 15 + 5
	var duplicated_material: Material = tree_texture.get_material().duplicate()
	tree_texture.set_material(duplicated_material)
	var random_number: int = randi() % base_texture_list.size()
	tree_texture.texture = load(base_texture_list[random_number])
	base_texture = base_texture_list[random_number]
	timer.start(growth_timer[current_state])
	
	
func on_growth_timer_timeout() -> void:
	current_state += 1
	match current_state:
		1:
			tree_texture.texture = load(trunk)
			timer.start(growth_timer[current_state])
			tree_texture.position = tree_position[current_state - 1]
			
		2:
			tree_texture.texture = load(full_tree)
			tree_texture.position = tree_position[current_state - 1]
			
			
func update_health(damage: int) -> void:
	if current_state != 0:
		health -= damage
		if health <= 0:
			initial_state()
			
		animation.play("tree_hit")
		Globals.instance_object(LEAVES, global_position)
		
		
func initial_state() -> void:
	current_state = 0
	health = randi() % 15 + 5
	tree_texture.position = Vector2.ZERO
	tree_texture.texture = load(base_texture)
	timer.start(growth_timer[current_state])
