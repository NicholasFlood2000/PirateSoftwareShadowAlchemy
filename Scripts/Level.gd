extends Node2D

@export var InitialBackground: String

@onready var EarthBackgroundMain = $EarthBackground
@onready var EarthBackgroundBack = $EarthBackground/EarthBackground2
@onready var EarthBackgroundMiddle = $EarthBackground/ParallaxLayer2/Sprite2D
@onready var EarthBackgroundFront = $EarthBackground/ParallaxLayer/Sprite2D
@onready var WaterBackgroundMain = $WaterBackground
@onready var WaterBackgroundBack = $WaterBackground/WaterBackground2
@onready var WaterBackgroundMiddle = $WaterBackground/ParallaxLayer2/Sprite2D
@onready var WaterBackgroundFront = $WaterBackground/ParallaxLayer3/Sprite2D

signal BackgroundChanged(NewBackground)

var LayerNum = -100
var CurrentBackground = "Water"
# Called when the node enters the scene tree for the first time.
func _ready():
	CurrentBackground = InitialBackground
	BackgroundChanged.emit( CurrentBackground )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("Debug")):
		print("Debug button pressed")
		if(CurrentBackground == "Earth"):
			toggleBackGround("Earth", "Water")
		elif(CurrentBackground == "Water"):
			toggleBackGround("Water", "Earth")

func toggleBackGround(OldBackground, NewBackground):
	if(OldBackground == "Earth"):
		if(NewBackground == "Water"):
			EarthBackgroundMain.layer = LayerNum
			WaterBackgroundMain.layer = LayerNum-1
			EarthBackgroundBack.visible = false
			WaterBackgroundBack.visible = true
			await get_tree().create_timer(1).timeout
			EarthBackgroundMiddle.visible = false
			WaterBackgroundMiddle.visible = true
			await get_tree().create_timer(1).timeout
			EarthBackgroundFront.visible = false
			WaterBackgroundFront.visible = true
			CurrentBackground = "Water"
	elif(OldBackground == "Water"):
		if(NewBackground == "Earth"):
			WaterBackgroundMain.layer = LayerNum
			EarthBackgroundMain.layer = LayerNum-1
			WaterBackgroundBack.visible = false
			EarthBackgroundBack.visible = true
			await get_tree().create_timer(1).timeout
			WaterBackgroundMiddle.visible = false
			EarthBackgroundMiddle.visible = true
			await get_tree().create_timer(1).timeout
			WaterBackgroundFront.visible = false
			EarthBackgroundFront.visible = true
			CurrentBackground = "Earth"
	
	BackgroundChanged.emit( CurrentBackground )
