extends CanvasLayer
class_name Hud

var score = 0
var timer = 200
var timerSpeedModifier = 1

@onready var lblScore : Label = get_node("lblScore")
@onready var lblTimer: Label = get_node("lblTimer")
@export var manager : RobotManager

func _process(delta: float) -> void:
	var newDelta = delta / 2 if manager.frezeTimer > 0 else delta
	timer -= newDelta * timerSpeedModifier
	timerSpeedModifier += newDelta * 0.02
	lblTimer.text = "%d" %  ceil(timer)

func add_score(s: int):
	score += s
	lblScore.text = "%d" %score

func add_timer(t: int):
	timer += t
