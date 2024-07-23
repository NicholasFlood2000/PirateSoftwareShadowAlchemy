extends CharacterBody2D

enum states {IDLE, WALKING, JUMP, FALLING, CLIMBING, JUMPED_FROM_CLIMBING}
enum  transformations {NORMAL, MOLE, FISH, BIRD}

#const SPEED = 400.0
const JUMP_VELOCITY = -500.0


@export var gravity = 1000
@export var jump_gravity = 900
@export var movement_speed = 500
@export var acceleration :float = 7.0
@export var deceleration :float = 10.0
@export var jump_velocity = 600.0

@export var coyote_set_time = 0.5
@export var jump_buffer_set_time = 0.5

@onready var vine_detection_marker = $VineDetection
@onready var water_detection_marker = $WaterDetection

@onready var animation_tree = $AnimationTree

@onready var animation_tree_statemachine = animation_tree["parameters/playback"]


var current_state :states = states.IDLE

var last_direction :int = 0
var hanging_vine = null

var coyote_timer :float = 0.0
var jump_buffer_timer :float = 0.0

func _ready():
	get_tree().current_scene.BackgroundChanged.connect(_BackgroundChanged)


func _physics_process(delta):
	
	var input_direction :Vector2 = Vector2.ZERO
	input_direction.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")#, "MoveUp", "MoveDown")
	input_direction.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	
	if Input.is_action_just_pressed("Jump"):
		#coyote_timer = coyote_set_time
		jump_buffer_timer = jump_buffer_set_time
	
	coyote_timer -= 1 * delta
	jump_buffer_timer -= 1 * delta
	
	print(coyote_timer, jump_buffer_timer)
	
	match(current_state):
		states.IDLE:
			animation_tree_statemachine.travel("idle")
			#$AnimationPlayer.play("idle")
			
			velocity.x = lerp(velocity.x, 0.0, deceleration * delta)
			
			if input_direction.x != 0:
				current_state = states.WALKING
			
			check_jump()
			check_whether_player_is_on_floor()
		
		states.WALKING:
			
			#if velocity.x > 0 and input_direction.x < 0:
				#animation_tree_statemachine.travel("turn_around")
			#elif velocity.x < 0 and input_direction.x > 0:
				#animation_tree_statemachine.travel("turn_around")
			
			
			velocity.x = lerp(velocity.x, input_direction.x * movement_speed, acceleration * delta)
			
			
			if input_direction.x == 0:
				current_state = states.IDLE
			#elif input_direction:
				#last_direction = $sprite.scale.x
			else:
				$sprite.scale.x = sign(input_direction.x)
				#if $sprite.scale.x >= last_direction or $sprite.scale.x <= last_direction:
					#animation_tree_statemachine.travel("turn_around")
				#else:
			animation_tree_statemachine.travel("walk")
			
			print(last_direction, $sprite.scale.x)
			#if $sprite.scale.x == 1 and input_direction.x < 0 and velocity.x != 0 or $sprite.scale.x == -1 and input_direction.x > 0  and velocity.x != 0:
				#animation_tree_statemachine.travel("turn_around")
				#$sprite.scale.x = 1 if input_direction.x > 0 else -1
			#else:
				#animation_tree_statemachine.travel("walk")
			
			check_jump()
			check_whether_player_is_on_floor()
			#check_whether_player_is_on_floor()
			
		states.JUMP:
			animation_tree_statemachine.travel("jump")
			velocity.y += jump_gravity * delta
			
			velocity.x = lerp(velocity.x, input_direction.x * movement_speed, acceleration * delta)
			
			
			if velocity.y < 0:
				current_state = states.FALLING
			
			if input_direction.x != 0:
				$sprite.scale.x = 1 if input_direction.x > 0 else -1
			
			if detect_vine():
				current_state = states.CLIMBING
				velocity.y = 0
		states.JUMPED_FROM_CLIMBING:
			animation_tree_statemachine.travel("jump")
			velocity.y += jump_gravity * delta
			
			velocity.x = lerp(velocity.x, input_direction.x * movement_speed, acceleration * delta)
			
			if velocity.y > 0:
				current_state = states.FALLING
			
			if input_direction.x != 0:
				$sprite.scale.x = 1 if input_direction.x > 0 else -1
			
		states.FALLING:
			animation_tree_statemachine.travel("fall")
			velocity.y += gravity * delta
			
			velocity.x = lerp(velocity.x, input_direction.x * movement_speed, acceleration * delta)
			
			if input_direction.x != 0:
				$sprite.scale.x = 1 if input_direction.x > 0 else -1
			
			check_jump()
			
			if detect_vine():
				#print("Fuck!!")
				#current_state = states.CLIMBING
				#velocity.y = 0 
				current_state = states.CLIMBING
			else:
				check_whether_player_is_on_floor()
			
		
		states.CLIMBING:
			velocity = velocity.lerp(input_direction * (movement_speed / 2), acceleration * delta)
			
			if Input.is_action_just_pressed("Jump"):
				velocity.y = -jump_velocity
				current_state = states.JUMPED_FROM_CLIMBING
			
			velocity.y += 850 * delta
			
			if not detect_vine():
				current_state = states.IDLE
			
			if input_direction.x != 0:
				$sprite.scale.x = 1 if input_direction.x > 0 else -1
	
#	This is there for testing, please change/remove when writting a proper system for it
#	We can make vine climbing by replacing with a velocity y lerp and adding
#	a climb action with w.
	

	move_and_slide()
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y *= 0.5
	
	#print(detect_vine())

func detect_vine() -> bool:
	if(not get_collision_mask_value(7)):
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

func die() -> void:
	get_tree().reload_current_scene()

# reusable state machine code
# I'm not lazy, I just hate redoing work.

func check_jump() -> void:
	
		
	if coyote_timer > 0.0 and jump_buffer_timer > 0.0:
		
		coyote_timer = 0
		jump_buffer_timer = 0
		velocity.y = -jump_velocity
		current_state = states.JUMP

func check_whether_player_is_on_floor() -> void:
	if not is_on_floor():
		if current_state != states.JUMP:
			current_state = states.FALLING
	if is_on_floor() and current_state != states.JUMP:
		coyote_timer = coyote_set_time
		if current_state == states.FALLING:
			current_state = states.IDLE
	#else:
	
	




func _BackgroundChanged(NewBackground):
	if(NewBackground == "Earth"):
		set_collision_mask_value(7, true)
	else:
		set_collision_mask_value(7, false)
