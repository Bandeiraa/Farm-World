extends YSort
class_name MapManager

var avaliable_tiles: Array = []

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
	for tile in terrain.grass.get_used_cells():
		if avaliable_tile(tile):
			avaliable_tiles.append(tile)
			
	for interactable in interactable_amount:
		var random_position: int = randi() % avaliable_tiles.size()
		var spawn_position: Vector2 = avaliable_tiles[random_position]
		avaliable_tiles.remove(random_position)
		add_interactable(spawn_position)
		
		
func avaliable_tile(tile: Vector2) -> bool:
	if terrain.sand_tiles_list.has(tile) or prop.prop_tiles_list.has(tile):
		return false
		
	return true
	
	
func add_interactable(tile_position: Vector2) -> void:
	var interactable_index: int = randi() % interactable_object_list.size()
	var interactable = load(interactable_object_list[interactable_index]).instance()
	interactable.position = tile_position * GlobalData.GRID_SIZE
	add_child(interactable)
