extends Sprite2D

var PlayerInRange: bool = false
var Level
@onready var Collision = $Area2D/CollisionShape2D
@export var EnvironmentPower: String
@export var RespawnTime: int

# Called when the node enters the scene tree for the first time.
func _ready():
	Level = get_tree().current_scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Interact") and PlayerInRange):
		print(Level.CurrentBackground != EnvironmentPower)
		if(Level.CurrentBackground != EnvironmentPower):
			Level.toggleBackGround(Level.CurrentBackground, EnvironmentPower)
			await get_tree().create_timer(2.5).timeout
			visible = false
			Collision.disabled = true
			Respawn()


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		PlayerInRange = true


func _on_area_2d_body_exited(body):
	if(body.name == "Player"):
		PlayerInRange = false

func Respawn():
	await get_tree().create_timer(RespawnTime).timeout
	visible = true
	Collision.disabled = false
	pass
