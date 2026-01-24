extends CanvasLayer
class_name Hud

var score = 0
@onready var lblScore : Label = get_node("lblScore")

func _process(delta: float) -> void:
	pass

func add_score(s: int):
	score += s
	lblScore.text = "%d" % score
