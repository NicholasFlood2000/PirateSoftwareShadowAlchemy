extends TextureRect

var time :float = 0.0

func _process(delta: float) -> void:
	time += 1 * delta
	position.y += sin(time * 4) / 6
