extends Button

@onready var Menu = $Menu
@onready var GameVolumeSlider = $Menu/VBoxContainer/GameVolumeSlider
@onready var MusicVolumeSlider = $Menu/VBoxContainer/MusicVolumeSlider
@onready var SoundVolumeSlider = $Menu/VBoxContainer/SoundEffectSlider
@onready var BlurSlider = $Menu/VBoxContainer/BlurSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	Menu.visible = false
	GameVolumeSlider.set_value_no_signal(GlobalSettings.MasterVolume)
	MusicVolumeSlider.set_value_no_signal(GlobalSettings.MusicVolume)
	SoundVolumeSlider.set_value_no_signal(GlobalSettings.SoundVolume)
	BlurSlider.set_value_no_signal(GlobalSettings.Blur)
	GameVolumeSlider.value_changed.connect(GlobalSettings.UpdateMasterVolume)
	MusicVolumeSlider.value_changed.connect(GlobalSettings.UpdateMusicVolume)
	SoundVolumeSlider.value_changed.connect(GlobalSettings.UpdateSoundVolume)
	BlurSlider.value_changed.connect(GlobalSettings.UpdateBlur)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Menu.visible = true
	pass # Replace with function body.


func _on_exit_button_pressed():
	Menu.visible = false
	pass # Replace with function body.

