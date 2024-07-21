extends Button

@onready var Menu = $Menu
@onready var GameVolumeSlider = $Menu/VBoxContainer/GameVolumeSlider
@onready var MusicVolumeSlider = $Menu/VBoxContainer/MusicVolumeSlider
#@onready var SoundVolumeSlider = $Menu/VBoxContainer/SoundVolumeSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	Menu.visible = false
	GameVolumeSlider.set_value_no_signal(GlobalSettings.MasterVolume)
	MusicVolumeSlider.set_value_no_signal(GlobalSettings.MusicVolume)
	#SoundVolumeSlider.set_value_no_signal(GlobalSettings.SoundVolume)
	GameVolumeSlider.value_changed.connect(GlobalSettings.UpdateMasterVolume)
	MusicVolumeSlider.value_changed.connect(GlobalSettings.UpdateMusicVolume)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Menu.visible = true
	pass # Replace with function body.


func _on_exit_button_pressed():
	Menu.visible = false
	pass # Replace with function body.

