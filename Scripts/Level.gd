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
@onready var AirBackgroundMain = $AirBackground
@onready var AirBackgroundBack = $AirBackground/AirBackground2
@onready var AirBackgroundMiddle = $AirBackground/ParallaxLayer2/Sprite2D
@onready var AirBackgroundFront = $AirBackground/ParallaxLayer3/Sprite2D

signal BackgroundChanged(NewBackground)

var LayerNum = -100
var CurrentBackground = InitialBackground
# Called when the node enters the scene tree for the first time.
func _ready():
	ScreenTransition.transition_out()
	BackgroundChanged.connect(Music._BackgroundChanged)
	CurrentBackground = InitialBackground
	BackgroundChanged.emit(CurrentBackground)
	match(CurrentBackground):
		"Air":
			AirBackgroundBack.visible = true
			AirBackgroundMiddle.visible = true
			AirBackgroundFront.visible = true
		"Earth":
			EarthBackgroundBack.visible = true
			EarthBackgroundMiddle.visible = true
			EarthBackgroundFront.visible = true
		"Water":
			WaterBackgroundBack.visible = true
			WaterBackgroundMiddle.visible = true
			WaterBackgroundFront.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
		elif(NewBackground == "Air"):
			EarthBackgroundMain.layer = LayerNum
			AirBackgroundMain.layer = LayerNum-1
			EarthBackgroundBack.visible = false
			AirBackgroundBack.visible = true
			await get_tree().create_timer(1).timeout
			EarthBackgroundMiddle.visible = false
			AirBackgroundMiddle.visible = true
			await get_tree().create_timer(1).timeout
			EarthBackgroundFront.visible = false
			AirBackgroundFront.visible = true
			CurrentBackground = "Air"
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
		elif(NewBackground == "Air"):
			WaterBackgroundMain.layer = LayerNum
			AirBackgroundMain.layer = LayerNum-1
			WaterBackgroundBack.visible = false
			AirBackgroundBack.visible = true
			await get_tree().create_timer(1).timeout
			WaterBackgroundMiddle.visible = false
			AirBackgroundMiddle.visible = true
			await get_tree().create_timer(1).timeout
			WaterBackgroundFront.visible = false
			AirBackgroundFront.visible = true
			CurrentBackground = "Air"
	elif(OldBackground == "Air"):
		if(NewBackground == "Water"):
			AirBackgroundMain.layer = LayerNum
			WaterBackgroundMain.layer = LayerNum-1
			AirBackgroundBack.visible = false
			WaterBackgroundBack.visible = true
			await get_tree().create_timer(1).timeout
			AirBackgroundMiddle.visible = false
			WaterBackgroundMiddle.visible = true
			await get_tree().create_timer(1).timeout
			AirBackgroundFront.visible = false
			WaterBackgroundFront.visible = true
			CurrentBackground = "Water"
		elif(NewBackground == "Earth"):
			AirBackgroundMain.layer = LayerNum
			EarthBackgroundMain.layer = LayerNum-1
			AirBackgroundBack.visible = false
			EarthBackgroundBack.visible = true
			await get_tree().create_timer(1).timeout
			AirBackgroundMiddle.visible = false
			EarthBackgroundMiddle.visible = true
			await get_tree().create_timer(1).timeout
			AirBackgroundFront.visible = false
			EarthBackgroundFront.visible = true
			CurrentBackground = "Earth"
	
	BackgroundChanged.emit( CurrentBackground )
