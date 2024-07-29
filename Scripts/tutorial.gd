extends Node2D

@onready var Screen = $Screen

var Visited: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if(body.name == "Player" and (not Visited)):
		Visited = true
		Screen.process_mode = Node.PROCESS_MODE_ALWAYS
		Screen.visible = true
		get_tree().paused = true
		print("Paused Player")
