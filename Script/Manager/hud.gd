extends CanvasLayer
class_name Hud

var score = 0
var timer = 100
var timerSpeedModifier = 1

@onready var lblScore : Label = get_node("lblScore")
@onready var lblTimer: Label = get_node("lblTimer")

func _process(delta: float) -> void:
	timer -= delta * timerSpeedModifier
	timerSpeedModifier += delta * 0.02
	lblTimer.text = "%d" %  ceil(timer)

func add_score(s: int):
	score += s
	lblScore.text = "%d" %score

func add_timer(t: int):
	timer += t
