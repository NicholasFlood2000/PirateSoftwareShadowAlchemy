extends Sprite2D

var PlayerInRange: bool = false
var Level

@export var EnvironmentPower: String

# Called when the node enters the scene tree for the first time.
func _ready():
	Level = get_tree().current_scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Interact") and PlayerInRange):
		if(Level.CurrentBackground != EnvironmentPower):
			Level.toggleBackGround(Level.CurrentBackground, EnvironmentPower)


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		PlayerInRange = true


func _on_area_2d_body_exited(body):
	if(body.name == "Player"):
		PlayerInRange = false
