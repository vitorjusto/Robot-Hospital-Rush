extends Node2D
class_name Main

var isPaused = false
var pausedObjects = []
@onready var clPause : CanvasLayer = get_node("clPause")
@onready var hud : Hud = get_node("hud")
@onready var clEndScreen : CanvasLayer = get_node("clEndScreen")
@onready var clConfirmScreen : CanvasLayer = get_node("clConfirmScreen")
@onready var lblScore : Label = get_node("clEndScreen/lblScore")

##PauseLabels
@onready var lblContinue : Label = get_node("clPause/lblPauseContinue")
@onready var lblRestart : Label = get_node("clPause/lblPauseRestart")
@onready var lblExit : Label = get_node("clPause/lblPauseExit")

##ConfirmLables
@onready var lblYes : Label = get_node("clConfirmScreen/lblYes")
@onready var lblNo : Label = get_node("clConfirmScreen/lblNo")

##EndLables
@onready var lblEndRestart : Label = get_node("clEndScreen/lblEndRestart")
@onready var lblEndExit : Label = get_node("clEndScreen/lblEndExit")

@export var rManager : RobotManager
@export var fManager : fixersManager
@export var player : Player
@export var powerUp : PowerUp
@export var bombRobot : BombRobot

var selectedIndex = 0
var yesSelected = false

func _process(delta: float) -> void:
	if clEndScreen.visible:
		if Input.is_action_just_pressed("Left"):
			selectedIndex = clamp(selectedIndex - 1, 0, 1)
		elif Input.is_action_just_pressed("Right"):
			selectedIndex = clamp(selectedIndex + 1, 0, 1)
			
		lblEndRestart.modulate = Color.WHITE
		lblEndExit.modulate = Color.WHITE
		
		if selectedIndex == 0:
			lblEndRestart.modulate = Color.BLUE
		elif selectedIndex == 1:
			lblEndExit.modulate =  Color.BLUE
		
		if Input.is_action_just_pressed("Shoot"):
			if selectedIndex == 0:
				reloadGame()
			elif selectedIndex == 1:
				get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
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
			selectedIndex = clamp(selectedIndex - 1, 0, 2)
		elif Input.is_action_just_pressed("Right"):
			selectedIndex = clamp(selectedIndex + 1, 0, 2)
		
		lblContinue.modulate =  Color.WHITE
		lblRestart.modulate = Color.WHITE
		lblExit.modulate = Color.WHITE
		
		if selectedIndex == 0:
			lblContinue.modulate = Color.BLUE
		elif selectedIndex == 1:
			lblRestart.modulate =  Color.BLUE
		elif selectedIndex == 2:
			lblExit.modulate =  Color.BLUE
		
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
	player.velocity = Vector2(0, 0)
	powerUp.resetPowerUp()
	bombRobot.ResetBombRobot()
	UnpauseObjects()
	clEndScreen.visible = false
	clConfirmScreen.visible = false
	clPause.visible = false
	isPaused = false
	selectedIndex = 0
	yesSelected = false
