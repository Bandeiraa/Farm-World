extends CollectableTemplate
class_name Trunk

func on_collectable_area_body_entered(body: CharacterBase) -> void:
	#Do logic to send item to inventory
	#print(body)
	queue_free()
