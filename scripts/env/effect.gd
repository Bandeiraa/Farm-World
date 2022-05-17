extends AnimatedSprite

func _ready() -> void:
	play()
	yield(self, "animation_finished")
	queue_free()
