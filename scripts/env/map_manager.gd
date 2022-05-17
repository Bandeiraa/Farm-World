extends YSort
class_name MapManager

var interactable_object_list: Array = [
	"res://scenes/interactable/bush/normal_bush.tscn"
]

export(int) var interactable_amount

export(NodePath) onready var prop = get_node(prop) as Node2D
export(NodePath) onready var terrain = get_node(terrain) as Node2D

func _ready() -> void:
	yield(owner, "ready")
	randomize()
	spawn_interactable_objects()
	
	
func spawn_interactable_objects() -> void:
	var amount: int = 0
	for tile in terrain.grass.get_used_cells():
		if avaliable_tile(tile):
			var random_number: int = randi() % 100
			if random_number <= interactable_amount and amount < interactable_amount:
				add_interactable(tile)
				amount += 1
				
				
func avaliable_tile(tile: Vector2) -> bool:
	if terrain.sand_tiles_list.has(tile) or prop.prop_tiles_list.has(tile):
		return false
		
	return true
	
	
func add_interactable(tile_position: Vector2) -> void:
	var interactable_index: int = randi() % interactable_object_list.size()
	var interactable = load(interactable_object_list[interactable_index]).instance()
	interactable.position = tile_position * GlobalData.GRID_SIZE
	add_child(interactable)
