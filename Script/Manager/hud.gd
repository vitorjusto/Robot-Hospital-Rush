extends CanvasLayer
class_name Hud

var score = 0
var timer = 200
var timerSpeedModifier = 1

@onready var lblScore : Label = get_node("lblScore")
@onready var lblTimer: Label = get_node("lblTimer")
@export var manager : RobotManager
@export var main : Main

func resetHud():
	score = 0
	timer = 200
	timerSpeedModifier = 1

func _process(delta: float) -> void:
	var newDelta = delta / 2 if manager.frezeTimer > 0 else delta
	timer -= newDelta * timerSpeedModifier
	timerSpeedModifier += newDelta * 0.02
	lblTimer.text = "%d" %  ceil(timer)
	
	if timer <= 0:
		main.EndGame()

func add_score(s: int):
	score += s
	lblScore.text = "%d" %score

func add_timer(t: int):
	timer += t
