extends Node2D
class_name Prop

onready var prop: TileMap = get_node("Prop")

onready var prop_id_list: Array = prop.tile_set.get_tiles_ids()

var busy_tiles_list: Array #Sand tiles list
var prop_tiles_list: Array #Prop tiles list
var avaliable_tiles: Array

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
	for tile in terrain.grass.get_used_cells():
		if avaliable_cell(tile):
			avaliable_tiles.append(tile)
			
	for prop_object in props_amount:
		var random_position: int = randi() % avaliable_tiles.size()
		var spawn_position: Vector2 = avaliable_tiles[random_position]
		avaliable_tiles.remove(random_position)
		prop.set_cellv(spawn_position, randi() % prop_id_list.size())
		prop_tiles_list.append(spawn_position)
		
		
func avaliable_cell(cell: Vector2) -> bool:
	if busy_tiles_list.has(cell):
		return false
		
	return true
