extends Sprite2D

@onready var Collision = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.BackgroundChanged.connect(_BackgroundChanged)


func _BackgroundChanged(NewBackground):
	if(NewBackground == "Air"):
		modulate = Colors.AirColor
		Collision.disabled = false
	else:
		modulate = Colors.ShadowColor
		Collision.disabled = true
