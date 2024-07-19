extends Button

@onready var Menu = $Menu
# Called when the node enters the scene tree for the first time.
func _ready():
	Menu.visible = false
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
