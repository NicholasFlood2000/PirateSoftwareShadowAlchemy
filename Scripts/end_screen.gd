extends Control

var old_scale = scale
# Called when the node enters the scene tree for the first time.
func _ready():
	if(visible):
		get_tree().paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().paused = false
	queue_free()


func _on_button_mouse_entered() -> void:
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($Button, "scale", old_scale / 0.8, 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_button_mouse_exited() -> void:
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($Button, "scale", old_scale, 0.1).set_trans(Tween.TRANS_CUBIC)
