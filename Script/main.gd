extends Node2D
class_name Main

var isPaused = false
var bestScore = 0
var pausedObjects = []
@onready var clPause : CanvasLayer = get_node("clPause")
@onready var hud : Hud = get_node("hud")
@onready var clEndScreen : CanvasLayer = get_node("clEndScreen")
@onready var clConfirmScreen : CanvasLayer = get_node("clConfirmScreen")
@onready var lblScore : Label = get_node("clEndScreen/lblScore")
@onready var lblBestScore : Label = get_node("clEndScreen/lblBestScore")

##PauseLabels
@onready var lblContinue : Label = get_node("clPause/lblPauseContinue")
@onready var lblRestart : Label = get_node("clPause/lblPauseRestart")

##ConfirmLables
@onready var lblYes : Label = get_node("clConfirmScreen/lblYes")
@onready var lblNo : Label = get_node("clConfirmScreen/lblNo")

##EndLables
@onready var lblEndRestart : Label = get_node("clEndScreen/lblEndRestart")

@export var rManager : RobotManager
@export var fManager : fixersManager
@export var player : Player
@export var powerUp : PowerUp
@export var bombRobot : BombRobot
@export var scoreManager : ScoreLabelManager

var selectedIndex = 0
var yesSelected = false

func _process(delta: float) -> void:
	if clEndScreen.visible:
		
		lblEndRestart.modulate = Color.BLUE
		
		if Input.is_action_just_pressed("Get"):
				reloadGame()
	elif Input.is_action_just_pressed("Pause") and not clConfirmScreen.visible:
		selectedIndex = 0
		isPaused = !isPaused
		clPause.visible = isPaused
		if isPaused:
			PauseObjects(get_children())
		else:
			UnpauseObjects()
	elif clConfirmScreen.visible:
		if Input.is_action_just_pressed("Left"):
			yesSelected = true
		elif Input.is_action_just_pressed("Right"):
			yesSelected = false
		
		lblYes.modulate =  Color.WHITE
		lblNo.modulate = Color.WHITE
		
		if yesSelected:
			lblYes.modulate =  Color.BLUE
		else:
			lblNo.modulate =  Color.BLUE
		
		if Input.is_action_just_pressed("Shoot"):
			if yesSelected:
				if selectedIndex == 1:
					reloadGame()
				elif selectedIndex == 2:
					get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
			else:
				clConfirmScreen.visible = false
	elif clPause.visible:
		
		if Input.is_action_just_pressed("Left"):
			selectedIndex = clamp(selectedIndex - 1, 0, 1)
		elif Input.is_action_just_pressed("Right"):
			selectedIndex = clamp(selectedIndex + 1, 0, 1)
		
		lblContinue.modulate =  Color.WHITE
		lblRestart.modulate = Color.WHITE
		
		if selectedIndex == 0:
			lblContinue.modulate = Color.BLUE
		elif selectedIndex == 1:
			lblRestart.modulate =  Color.BLUE
		
		if Input.is_action_just_pressed("Shoot"):
			if selectedIndex == 0:
				selectedIndex = 0
				isPaused = !isPaused
				clPause.visible = isPaused
				UnpauseObjects()
			else:
				clConfirmScreen.visible = true
	


func UnpauseObjects():
	for i in pausedObjects:
		i.set_physics_process(true)
		i.set_process(true)
		if i is AnimatedSprite2D:
			var ani : AnimatedSprite2D = i
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
		
		PauseObjects(i.get_children())

func EndGame():
	PauseObjects(get_children())
	clEndScreen.visible = true
	rManager.deactivateEveryRobot()
	lblScore.text = "Score: %d" % hud.score
	
	if hud.score > bestScore:
		bestScore = hud.score
		lblBestScore.modulate = Color.YELLOW
	else:
		lblBestScore.modulate = Color.LIGHT_GRAY
	
	lblBestScore.text = "Best Score: %d" % bestScore

func reloadGame():
	rManager.resetManager()
	fManager.resetManager()
	hud.resetHud()
	player.position = Vector2(960, 968)
	player.velocity = Vector2(0, 0)
	powerUp.resetPowerUp()
	bombRobot.ResetBombRobot()
	scoreManager.resetScore()
	UnpauseObjects()
	clEndScreen.visible = false
	clConfirmScreen.visible = false
	clPause.visible = false
	isPaused = false
	selectedIndex = 0
	yesSelected = false
