extends Area2D

var Level
var PlayerInside: bool = false
var Player

@export var Background: String = "Earth"

func _ready():
	Level = get_tree().current_scene

func _process(delta):
	if(Input.is_action_just_pressed("Interact") and PlayerInside):
		if(Player.current_transform == Player.transformations.BIRD):
			Player.current_transform = Player.transformations.NORMAL
			Level.toggleBackGround(Level.CurrentBackground, Background)
		else:
			Player.current_transform = Player.transformations.BIRD
			Level.toggleBackGround(Level.CurrentBackground, "Air")

func _on_body_entered(body):
	if(body.name == "Player"):
		PlayerInside = true
		Player = body


func _on_body_exited(body):
	if(body.name == "Player"):
		PlayerInside = false
		Player = body
