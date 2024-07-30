extends Node

var MasterVolume: int = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
var MusicVolume: int = 1
var SoundVolume: int = -2
var Blur: float = 0.0

signal MusicVolumeChanged
signal SoundEffectChanged
signal BlurChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Debug")):
		pass


func UpdateMasterVolume(NewVolume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), NewVolume)
	MasterVolume = NewVolume
	pass

func UpdateMusicVolume(NewVolume):
	MusicVolume = NewVolume
	MusicVolumeChanged.emit()
	pass
	
func UpdateSoundVolume(NewVolume):
	pass

func UpdateBlur(NewBlur):
	Blur = NewBlur
	BlurChanged.emit()
	pass
