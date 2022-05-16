extends Node2D
class_name CharacterBody

var current_key: String = "idle"
var sprites_dict: Dictionary = {
	"idle": [
		"",
		"",
		""
	],
	
	"walk": [
		"",
		"",
		""
	],
	
	"run": [
		"",
		"",
		""
	]
}

export(NodePath) onready var character = get_node(character) as KinematicBody2D
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

func _ready() -> void:
	get_character_info()
	
	
func get_character_info() -> void:
	for key in sprites_dict.keys():
		for index in get_child_count():
			sprites_dict[key][index] = GlobalData.player_skin_data[key][index]
			
			
func animate() -> void:
	verify_direction()
	move_behavior()
	
	
func verify_direction() -> void:
	if character.velocity.x > 0:
		change_direction(false)
	elif character.velocity.x < 0:
		change_direction(true)
		
		
func move_behavior() -> void:
	if character.is_sprint and character.velocity != Vector2.ZERO:
		change_sprite("run")
	elif character.velocity != Vector2.ZERO:
		change_sprite("walk")
	else:
		change_sprite("idle")
		
		
func change_sprite(anim: String) -> void:
	for children in get_children():
		children.texture = load(sprites_dict[anim][children.get_index()])
		
	animation.play(anim)
	
	
func change_direction(is_flipped: bool) -> void:
	for children in get_children():
		children.flip_h = is_flipped
