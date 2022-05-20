extends Node2D
class_name Level

onready var grass_terrain: Node2D = get_node("Terrain/Grass")
onready var character: KinematicBody2D = get_node("MapManager/Character")
onready var character_camera: Camera2D = character.get_node("Camera")

func _ready() -> void:
	define_camera_limits()
	
	
func define_camera_limits() -> void:
	var used_rect: Rect2 = grass_terrain.get_used_rect()
	character_camera.limit_left = int(used_rect.position.x)
	character_camera.limit_top = int(used_rect.position.y)
	character_camera.limit_right = int(used_rect.size.x * GlobalData.GRID_SIZE.x)
	character_camera.limit_bottom = int(used_rect.size.y * GlobalData.GRID_SIZE.y)
