extends YSort
class_name MapManager

var avaliable_tiles: Array = []

var rock_list: Array = [
	"res://scenes/interactable/rock.tscn"
]

var bush_list: Array = [
	"res://scenes/interactable/bush/normal_bush.tscn",
	"res://scenes/interactable/bush/strawberry_bush.tscn"
]

export(int) var bush_amount
export(int) var rock_amount

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
			
	spawn_interactable(bush_list, bush_amount)
	spawn_interactable(rock_list, rock_amount)
	
	
func avaliable_tile(tile: Vector2) -> bool:
	if terrain.full_sand_tiles_list.has(tile) or prop.prop_tiles_list.has(tile):
		return false
		
	return true
	
	
func spawn_interactable(list: Array, amount: int) -> void:
	for interactable in amount:
		var random_position: int = randi() % avaliable_tiles.size()
		var spawn_position: Vector2 = avaliable_tiles[random_position]
		avaliable_tiles.remove(random_position)
		add_interactable(spawn_position, list)
		
		
func add_interactable(tile_position: Vector2, interactable_list: Array) -> void:
	var interactable_index: int = randi() % interactable_list.size()
	var interactable = load(interactable_list[interactable_index]).instance()
	interactable.position = tile_position * GlobalData.GRID_SIZE
	add_child(interactable)
