extends CharacterBody2D


#const SPEED = 400.0
const JUMP_VELOCITY = -500.0


@export var gravity = 1000
@export var movement_speed = 500
@export var acceleration :float = 7.0
@export var deceleration :float = 10.0
@export var jump_velocity = -600.0

@export var coyote_set_time = 0.5
@export var jump_buffer_set_time = 0.5

@onready var vine_detection_marker = $VineDetection
@onready var water_detection_marker = $WaterDetection




# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hanging_vine = null

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().current_scene.BackgroundChanged.connect(_BackgroundChanged)
	pass # Replace with function body.

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = lerp(velocity.x, direction * movement_speed, acceleration * delta)
		#velocity.x = direction * movement_speed
		$sprite.scale.x = 1 if direction > 0 else -1
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
		velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
	
#	This is there for testing, please change/remove when writting a proper system for it
#	We can make vine climbing by replacing with a velocity y lerp and adding
#	a climb action with w.
	if detect_vine():
		velocity.y = 0
		pass

	move_and_slide()
	
	#print(detect_vine())

func detect_vine() -> bool:
	if(not get_collision_mask_value(10)):
		return false
	var space_state = get_world_2d().direct_space_state
	var shape_queary = PhysicsPointQueryParameters2D.new()
	
	shape_queary.position = vine_detection_marker.global_position
	shape_queary.collide_with_areas = true;
	shape_queary.collide_with_bodies = true;
	shape_queary.collision_mask = 1 << 9 
	if hanging_vine:
		shape_queary.exclude = [ hanging_vine ]
	
	var result := space_state.intersect_point(shape_queary, 1)
	
	if result:
		return true
	
	return false

func detect_water() -> bool:
	
	var space_state = get_world_2d().direct_space_state
	var shape_queary = PhysicsPointQueryParameters2D.new()
	
	shape_queary.position = vine_detection_marker.global_position
	shape_queary.collide_with_areas = true;
	shape_queary.collide_with_bodies = false;
	shape_queary.collision_mask = 1 << 10
	
	var result := space_state.intersect_point(shape_queary, 1)
	
	if result:
		return true
	
	return false

func _BackgroundChanged(NewBackground):
	if(NewBackground == "Earth"):
		set_collision_mask_value(10, true)
	else:
		set_collision_mask_value(10, false)
