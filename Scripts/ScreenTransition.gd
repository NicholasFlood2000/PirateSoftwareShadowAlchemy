extends CanvasLayer

func transition_in():
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	$ColorRect.modulate.a = 0
	
	tween.tween_property($ColorRect, "modulate", Color(1,1,1,1), 1.0).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished

func transition_out():
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	$ColorRect.modulate.a = 1
	tween.tween_property($ColorRect, "modulate", Color(1,1,1,0.0), 1.0).set_trans(Tween.TRANS_CUBIC)
	print("Started transitioning")
	await tween.finished
	print("Done transitioning")
