extends Node2D

@export var HorizontalFlip: bool

@onready var Front = $CaveEntranceFront
@onready var Back = $CaveEntranceBack
@onready var Collision = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Front.flip_h = HorizontalFlip
	Back.flip_h = HorizontalFlip
	Collision.position.x = -Collision.position.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if(body.name != "TileMap"):
		LevelProgression.LoadNextLevel()
	pass # Replace with function body.
