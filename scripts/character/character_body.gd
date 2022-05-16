extends Node2D
class_name CharacterBody

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
	],
	
	"dig": [
		"",
		"",
		""
	],
	
	"axe": [
		"",
		"",
		""
	],
	
	"mining": [
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
	if character.is_digging or character.is_axing or character.is_mining:
		action_behavior()
	else:
		move_behavior()
		
		
func verify_direction() -> void:
	if character.velocity.x > 0:
		change_direction(false)
	elif character.velocity.x < 0:
		change_direction(true)
		
		
func action_behavior() -> void:
	character.on_action = true
	character.set_physics_process(false)
	if character.is_digging:
		change_sprite("dig")
		
	elif character.is_axing:
		change_sprite("axe")
		
	elif character.is_mining:
		change_sprite("mining")
		
		
func move_behavior() -> void:
	if character.is_sprinting and character.velocity != Vector2.ZERO:
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
		
		
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"dig":
			character.is_digging = false
			
		"axe":
			character.is_axing = false
			
		"mining":
			character.is_mining = false
