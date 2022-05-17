extends Node

func instance_object(object_path: String, object_position: Vector2) -> void:
	var object = load(object_path).instance()
	object.global_position = object_position
	get_tree().root.call_deferred("add_child", object)
