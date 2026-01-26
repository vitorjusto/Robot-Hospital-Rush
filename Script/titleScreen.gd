extends Node2D

class ScoreUser:
	var name = "1"
	var score = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Get"):
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
