extends Node2D
class_name Map

onready var sand: TileMap = get_node("Sand")
onready var grass: TileMap = get_node("Grass")
onready var fence: TileMap = get_node("Fence")

var sand_tiles_list: Array
var grass_tiles_list: Array

var initial_position: float
var full_sand_tiles_list: Array

export(Vector2) var grass_tile_length
export(Vector2) var sand_tile_length

func _ready() -> void:
	randomize()
	spawn_initial_tile(grass, grass_tile_length)
	initial_sand_position(sand, sand_tile_length)
	tile_configuration(grass)
	tile_configuration(sand)
	fence_configuration()
	
	
func initial_sand_position(tile: TileMap, sand_length: Vector2) -> void:
	var spawn_range: int = int(grass_tile_length.x - sand_tile_length.x)
	initial_position = randi() % spawn_range + 1
	for x in sand_length.x:
		for y in sand_length.y:
			if tile.name == "Sand":
				tile.set_cellv(Vector2(x + initial_position, y + initial_position), 0)
				
				
	tile.update_bitmask_region()
	full_sand_tiles_list = get_sand_cells()
	
	
func get_sand_cells() -> Array:
	var sand_used_rect: Rect2 = sand.get_used_rect()
	var min_x_value: float = sand_used_rect.position.x - 1
	var max_x_value: float = sand_used_rect.size.x + min_x_value + 2
	var min_y_value: float = sand_used_rect.position.y - 1
	var max_y_value: float = sand_used_rect.size.y + min_y_value + 2
	
	var sand_tiles: Array = []
	for x in range(min_x_value, max_x_value):
		for y in range(min_y_value, max_y_value):
			sand_tiles.append(Vector2(x, y))
			
	return sand_tiles
	
	
func spawn_initial_tile(tile: TileMap, length: Vector2) -> void:
	for x in length.x:
		for y in length.y:
			tile.set_cellv(Vector2(x, y), 0)
			
	tile.update_bitmask_region()
	
	
func tile_configuration(tile: TileMap) -> void:
	var used_rect: Rect2 = tile.get_used_rect()
	var initial_x_position: float = used_rect.position.x + 2
	var initial_y_position: float = used_rect.position.y + 2
	var final_x_position: float = used_rect.size.x - 3
	var final_y_position: float = used_rect.size.y - 3
	
	for x in range(initial_x_position, final_x_position + initial_x_position):
		for y in range(initial_y_position, final_y_position + initial_y_position):
			match tile.name:
				"Grass":
					grass_tiles_list.append(Vector2(x, y))
					
				"Sand":
					sand_tiles_list.append(Vector2(x, y))
					
					
func fence_configuration() -> void:
	var used_rect: Rect2 = grass.get_used_rect()
	for x in range(used_rect.position.x, used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.size.y):
			if x == used_rect.position.x or x == used_rect.size.x - 1 or y == used_rect.position.y or y == used_rect.size.y - 1:
				fence.set_cellv(Vector2(x, y), 0)
				
	fence.update_bitmask_region()
