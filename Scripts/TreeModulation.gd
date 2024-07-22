extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.BackgroundChanged.connect(_BackgroundChanged)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _BackgroundChanged(NewBackground):
	if(NewBackground == "Earth"):
		modulate = Colors.EarthColor
	else:
		modulate = Colors.ShadowColor
	pass
