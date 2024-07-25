extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSettings.BlurChanged.connect(UpdateBlur)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func UpdateBlur():
	#Code to update blur
	pass
