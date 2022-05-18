extends InteractableTemplate

onready var texture: Sprite = get_node("Texture")

var textures_list: Array = [
	"res://assets/interactable/rock/type_1.png",
	"res://assets/interactable/rock/type_2.png",
	"res://assets/interactable/rock/type_3.png",
	"res://assets/interactable/rock/type_4.png"
]

func _ready() -> void:
	randomize()
	health = randi() % 15 + 5
	var duplicated_material: Material = texture.get_material().duplicate()
	texture.set_material(duplicated_material)
	random_texture()
	
	
func random_texture() -> void:
	var random_number: int = randi() % textures_list.size()
	texture.texture = load(textures_list[random_number])
	
	
func update_health(damage: int) -> void:
	health -= damage
	if health <= 0:
		kill()
		
	animation.play("rock_hit")
	
	
func kill() -> void:
	print("Spawn Rocks!!!")
	queue_free()
