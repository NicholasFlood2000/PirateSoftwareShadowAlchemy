extends Control







# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Pause")):
		visible = not visible
		get_tree().paused = not get_tree().paused 
		

func _on_exit_button_pressed():
	visible = false
	get_tree().paused = false
