extends Node2D
class_name Map

onready var sand: TileMap = get_node("Sand")
onready var grass: TileMap = get_node("Grass")

var sand_tiles_list: Array
var full_sand_tiles_list: Array

func _ready() -> void:
	var sand_used_rect: Rect2 = sand.get_used_rect()
	var initial_x_position: float = sand_used_rect.position.x + 1
	var initial_y_position: float = sand_used_rect.position.y + 1
	var final_x_position: float = sand_used_rect.size.x - 2
	var final_y_position: float = sand_used_rect.size.y - 2
	
	for x in range(initial_x_position, final_x_position + initial_x_position):
		for y in range(initial_y_position, final_y_position + initial_y_position):
			sand_tiles_list.append(Vector2(x, y))
