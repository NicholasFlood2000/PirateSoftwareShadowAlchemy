extends Button

var old_scale = scale

func _on_pressed():
	
	await ScreenTransition.transition_in()
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	print("Hovered")
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "scale", old_scale / 0.8, 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "scale", old_scale, 0.1).set_trans(Tween.TRANS_CUBIC)
