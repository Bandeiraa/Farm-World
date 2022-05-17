extends Node2D
class_name Map

onready var terrain: TileMap = get_node("Terrain")
onready var prop: TileMap = get_node("Prop")

onready var prop_id_list: Array = prop.tile_set.get_tiles_ids()

export(int) var props_amount

func _ready() -> void:
	randomize()
	var amount: int = 0
	for tile in terrain.get_used_cells():
		var random_number: int = randi() % 300
		if amount <= props_amount and random_number <= props_amount:
			prop.set_cellv(tile, randi() % prop_id_list.size())
			amount += 1
