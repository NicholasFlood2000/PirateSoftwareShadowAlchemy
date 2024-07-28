extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	volume_db = GlobalSettings.MusicVolume
	GlobalSettings.MusicVolumeChanged.connect(UpdateVolume)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func UpdateVolume():
	volume_db = GlobalSettings.MusicVolume
	pass
