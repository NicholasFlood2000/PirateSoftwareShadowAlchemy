extends Node

@onready var Earth = $Earth
@onready var Water = $Water
@onready var Air = $Air

var Level
# Called when the node enters the scene tree for the first time.
func _ready():
	Water.play()
	if(get_tree().current_scene.name == "BaseLevel"):
		Level = get_tree().current_scene
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Debug")):
		print("Manager")
		if(Air.playing):
			print(Air.volume_db)
		if(Water.playing):
			print(Water.volume_db)
		if(Earth.playing):
			print(Earth.volume_db)

func _BackgroundChanged(NewBackground):
	match(NewBackground):
		"Air":
			#$Water.
			var tween = get_tree().create_tween()
			tween.tween_property(Earth, "volume_db" , -80, 2.0).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(Water, "volume_db" , -80, 2.0).set_trans(Tween.TRANS_CUBIC)
			await tween.finished
			tween.kill()
			
			Water.playing = false
			if(Earth.playing):
				Earth.playing = false
			if(not Air.playing):
				Air.play()
				tween = get_tree().create_tween()
				tween.tween_property(Air, "volume_db" , GlobalSettings.MusicVolume , 2.0).set_trans(Tween.TRANS_CUBIC)
				
		"Water":
			var tween = get_tree().create_tween()
			tween.tween_property(Earth, "volume_db" , -80, 2.0).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(Air, "volume_db" , -80, 2.0).set_trans(Tween.TRANS_CUBIC)
			await tween.finished
			tween.kill()
			
			if(not Water.playing):
				Water.play()
				tween = get_tree().create_tween()
				tween.tween_property(Water, "volume_db" , GlobalSettings.MusicVolume, 2.0).set_trans(Tween.TRANS_CUBIC)
			Earth.playing = false
			Air.playing = false
		"Earth":
			var tween = get_tree().create_tween()
			tween.tween_property(Water, "volume_db" , -80, 2.0).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(Air, "volume_db" , -80, 2.0).set_trans(Tween.TRANS_CUBIC)
			await tween.finished
			tween.kill()
			
			Water.playing = false
			if(not Earth.playing):
				Earth.play()
				tween = get_tree().create_tween()
				tween.tween_property(Earth, "volume_db" , GlobalSettings.MusicVolume, 2.0).set_trans(Tween.TRANS_CUBIC)
				#Earth.volume_db = 0
				
			Air.playing = false
