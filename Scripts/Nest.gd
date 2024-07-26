extends Area2D



func _on_body_entered(body):
	if(body.name == "Player"):
		body.current_transform = body.transformations.BIRD
		pass
