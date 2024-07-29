extends Button

var old_scale = scale

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", old_scale / 0.8, 0.1).set_trans(Tween.TRANS_CUBIC)

func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", old_scale, 0.1).set_trans(Tween.TRANS_CUBIC)
