extends Node2D

class ScoreUser:
	var name = "1"
	var score = 1

func _process(delta: float) -> void:
	loadGame()
	if Input.is_action_just_pressed("Shoot"):
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func loadGame() -> Array[ScoreUser]:
	if OS.has_feature("web"):
		var result = JavaScriptBridge.eval("""
			localStorage.getItem('savegame') || '{}';
		""")
		return JSON.parse_string(str(result))
	else:
		if not FileAccess.file_exists("user://savegame.save"):
			return []
		var data = FileAccess.get_file_as_string("user://savegame.save")
		var leaderboard : Array[ScoreUser] = JSON.to_native(data)
		return leaderboard
