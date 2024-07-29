extends Node2D

@onready var Screen = $Screen

var PlayerInside = false
var Visited: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Interact") and (not Visited) and PlayerInside):
		Visited = true
		Screen.process_mode = Node.PROCESS_MODE_ALWAYS
		Screen.visible = true
		get_tree().paused = true


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		PlayerInside = true


func _on_area_2d_body_exited(body):
	if(body.name == "Player"):
		PlayerInside = false
