extends CanvasLayer
class_name Hud

var score = 0
var timer = 200
var timerSpeedModifier = 1

@onready var lblScore : Label = get_node("lblScore")
@onready var lblTimer: Label = get_node("lblTimer")
@onready var lblStreak: Label = get_node("lblStreak")

@export var manager : RobotManager
@export var main : Main
@onready var scoreManager : ScoreLabelManager = get_tree().root.get_node("/root/Main/ScoreLabelManager")
@onready var FixersManager : fixersManager = get_tree().root.get_node("/root/Main/FixersManager")

var explosionCooldown = 0
func resetHud():
	score = 0
	timer = 200
	timerSpeedModifier = 1
	lblScore.text = "SCORE: %d" %score

func _process(delta: float) -> void:
	var newDelta = delta / 2 if manager.frezeTimer > 0 else delta
	timer -= newDelta * timerSpeedModifier
	timerSpeedModifier += newDelta * 0.02
	lblTimer.text = "TIME: %d" %  ceil(timer)
	lblStreak.text = "STREAK: %d" % FixersManager.streak
	if timer <= 0:
		main.EndGame()
	elif timer <= 20:
		explosionCooldown -= delta
		
		if explosionCooldown <= 0:
			if lblTimer.modulate == Color.RED:
				lblTimer.modulate = Color.YELLOW
			else:
				lblTimer.modulate = Color.RED
			explosionCooldown = 0.1
	elif timer <= 50:
		lblTimer.modulate = Color.RED
	elif timer <= 100:
		lblTimer.modulate = Color.YELLOW
	else:
		lblTimer.modulate = Color.WHITE

func add_score(s: int, pos : Vector2):
	score += s
	lblScore.text = "SCORE: %d" %score
	scoreManager.setLabel(s, pos)

func add_timer(t: int):
	timer += t
