extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.BackgroundChanged.connect(_BackgroundChanged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _BackgroundChanged(NewBackground):
	print("New Background")
	if(NewBackground == "Earth"):
		print("Background is Earth")
		set_layer_modulate(1, Colors.EarthColor)
	else:
		print("Background is Water")
		set_layer_modulate(1, Colors.ShadowColor)
	pass