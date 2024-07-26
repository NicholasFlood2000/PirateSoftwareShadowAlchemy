extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSettings.BlurChanged.connect(UpdateBlur)
	self.material.set("shader_parameter/lod_value", 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func UpdateBlur():
	#Code to update blur
	pass
