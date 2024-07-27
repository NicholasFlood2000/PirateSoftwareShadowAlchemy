extends Node

var Levels = ["res://Scenes/Levels/Level_2.tscn", "res://Scenes/Levels/Level_3.tscn", "res://Scenes/Levels/test/TestTest.tscn"]
var CurrentLevel = 0

#This does not count Level 1 because Play Button Handles Level 1
func LoadNextLevel():
	if(CurrentLevel == len(Levels)):
		print("Game Beat")
	else:
		get_tree().change_scene_to_file(Levels[CurrentLevel])
		CurrentLevel += 1
