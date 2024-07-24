extends Node

var Levels = ["res://Scenes/Levels/Level_1.tscn"]
var CurrentLevel = 0

#This does not count Level 1 because Play Button Handles Level 1
func LoadNextLevel():
	get_tree().change_scene_to_file(Levels[CurrentLevel])
	CurrentLevel += 1
	pass
