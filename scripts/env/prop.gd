extends Node2D
class_name Prop

onready var prop: TileMap = get_node("Prop")

onready var prop_id_list: Array = prop.tile_set.get_tiles_ids()

var busy_tiles_list: Array #Sand tiles list

export(int) var props_amount

export(NodePath) onready var terrain = get_node(terrain) as Node2D

func _ready() -> void:
	randomize()
	get_sand_tile_info()
	spawn_prop_tile()
	
	
func get_sand_tile_info() -> void:
	for tile in terrain.sand.get_used_cells():
		busy_tiles_list.append(tile)
		
	terrain.sand_tiles_list = busy_tiles_list
	
	
func spawn_prop_tile() -> void:
	var amount: int = 0
	for tile in terrain.grass.get_used_cells():
		if avaliable_cell(tile):
			var random_number: int = randi() % 300
			if amount <= props_amount and random_number <= props_amount:
				prop.set_cellv(tile, randi() % prop_id_list.size())
				amount += 1
				
				
func avaliable_cell(cell: Vector2) -> bool:
	if busy_tiles_list.has(cell):
		return false
		
	return true
