extends Node

@onready var Earth = $Earth
@onready var Water = $Water
@onready var Air = $Air

# Called when the node enters the scene tree for the first time.
func _ready():
	Water.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _BackgroundChanged(NewBackground):
	match(NewBackground):
		"Air":
			Water.playing = false
			Earth.playing = false
			if(not Air.playing):
				Air.play()
		"Water":
			if(not Water.playing):
				Water.play()
			Earth.playing = false
			Air.playing = false
		"Earth":
			Water.playing = false
			if(not Earth.playing):
				Earth.play()
			Air.playing = false
