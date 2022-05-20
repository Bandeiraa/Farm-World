extends Node2D
class_name Prop

onready var prop: TileMap = get_node("Prop")

onready var prop_id_list: Array = prop.tile_set.get_tiles_ids()

var busy_tiles_list: Array #Sand tiles list
var prop_tiles_list: Array #Prop tiles list
var avaliable_tiles: Array

export(int) var props_amount

export(NodePath) onready var terrain = get_node(terrain) as Node2D

func _ready():
	randomize()
	busy_tiles_list = terrain.full_sand_tiles_list
	spawn_prop_tile()
	
	
func spawn_prop_tile() -> void:
	for tile in terrain.grass_tiles_list:
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
