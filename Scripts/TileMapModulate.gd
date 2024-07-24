extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.BackgroundChanged.connect(_BackgroundChanged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _BackgroundChanged(NewBackground):
	if(NewBackground == "Earth"):
		set_layer_modulate(1, Colors.EarthColor)
		set_layer_modulate(2, Colors.Invisble)
		set_layer_modulate(3, Colors.Invisble)
	else:
		set_layer_modulate(1, Colors.ShadowColor)
		set_layer_modulate(2, Colors.NetColor)
		set_layer_modulate(3, Colors.WaterColor)
