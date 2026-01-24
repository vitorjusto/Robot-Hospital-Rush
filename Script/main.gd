extends Node2D
class_name Main

var isPaused = false
var pausedObjects = []
@onready var clPause : CanvasLayer = get_node("clPause")
@onready var hud : Hud = get_node("hud")
@onready var clEndScreen : CanvasLayer = get_node("clEndScreen")
@onready var lblScore : Label = get_node("clEndScreen/lblScore")

@export var rManager : RobotManager
@export var fManager : fixersManager
@export var player : Player
@export var powerUp : PowerUp
@export var bombRobot : BombRobot

func _process(delta: float) -> void:
	if clEndScreen.visible:
		if Input.is_action_just_pressed("Shoot"):
			reloadGame()
	elif Input.is_action_just_pressed("Pause"):
		isPaused = !isPaused
		clPause.visible = isPaused
		if isPaused:
			PauseObjects(get_children())
		else:
			UnpauseObjects()

func UnpauseObjects():
	for i in pausedObjects:
		i.set_physics_process(true)
		i.set_process(true)
		if i is AnimatedSprite2D:
			var ani : AnimatedSprite2D = i
			ani.play()
		if i is AnimationPlayer:
			var ani : AnimationPlayer = i
			ani.play()
			
	pausedObjects.clear()

func PauseObjects(nodes : Array[Node]):
	for i in nodes:
		if i.process_mode == PROCESS_MODE_DISABLED:
			continue
		
		pausedObjects.append(i)
		i.set_physics_process(false)
		i.set_process(false)
		
		if i is AnimatedSprite2D:
			var ani : AnimatedSprite2D = i
			ani.pause()
			
		if i is AnimationPlayer:
			var ani : AnimationPlayer = i
			ani.pause()
		
		PauseObjects(i.get_children())

func EndGame():
	PauseObjects(get_children())
	clEndScreen.visible = true
	rManager.deactivateEveryRobot()
	lblScore.text = "%d" % hud.score

func reloadGame():
	rManager.resetManager()
	fManager.resetManager()
	hud.resetHud()
	player.position = Vector2(960, 1000)
	powerUp.resetPowerUp()
	bombRobot.ResetBombRobot()
	UnpauseObjects()
	clEndScreen.visible = false
