extends Node

func instance_object(object_path: String, object_position: Vector2, additional_argument) -> void:
	var object = load(object_path).instance()
	object.global_position = object_position
	if additional_argument != null:
		object.additional_argument = additional_argument
		
	get_tree().root.call_deferred("add_child", object)
