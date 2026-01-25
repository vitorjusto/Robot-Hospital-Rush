extends Node2D
class_name ScoreLabelManager

@onready var scores : Array[ScoreLabel]
@onready var scoreScene : PackedScene = load("res://Scenes/ScoreLabels.tscn")

func _ready() -> void:
	for i in range(0, 10):
		addProj()

func resetScore():
	for i in scores:
		i.setActive(false)

func addProj() -> ScoreLabel:
	var instance : ScoreLabel = scoreScene.instantiate()
	add_child(instance)
	scores.append(instance)
	return instance

func setLabel(score: int, pos: Vector2):
	
	var inactive = scores.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addProj()
		
	instance.setActive(true)
	instance.position = pos
	instance.setScore(score)
	
	return instance
