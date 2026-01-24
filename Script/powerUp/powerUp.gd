extends Area2D
class_name PowerUp

enum EPOWERUPTYPE{ TimerUp, ScoreMult, ScoreFrenzy, SuperTimerUp, SuperScoreMult, ScreenNuke, FrezeTime}
enum ESTATE{ Idle, Running}
@export var Type : EPOWERUPTYPE
@onready var hud : Hud = get_tree().root.get_node("/root/Main/hud")
@onready var manager : fixersManager = get_tree().root.get_node("/root/Main/FixersManager")
@onready var robotManager : RobotManager = get_tree().root.get_node("/root/Main/RobotManager")

const INITIAL_STATE = ESTATE.Idle
const INITIAL_TIMER = 5
const INITIAL_SPEED = 400

var state : ESTATE = INITIAL_STATE
var timer = INITIAL_TIMER
var startOnLeft = true
var speed = INITIAL_SPEED

@onready var col : CollisionShape2D = get_node("CollisionShape2D")

@export var leftAnchor: Node2D
@export var rightAnchor: Node2D

func resetPowerUp():
	state = INITIAL_STATE
	startOnLeft = true
	speed = INITIAL_SPEED
	timer = INITIAL_TIMER

func _process(delta: float) -> void:
	if state == ESTATE.Idle:
		timer -= delta
		if timer <= 0:
			set_running_state()
	else:
		position.x += speed * delta
		if position.x < leftAnchor.position.x or position.x > rightAnchor.position.x:
			set_idle_state()
		

func set_running_state():
	col.set_deferred("disabled", false)
	state = ESTATE.Running
	if startOnLeft:
		position = leftAnchor.position
		speed = 400
	else:
		position = rightAnchor.position
		speed = -400
	
	var rng = randi_range(0, 6)
	
	if rng == 0:
		Type = EPOWERUPTYPE.TimerUp
	elif rng == 1:
		Type = EPOWERUPTYPE.ScoreMult
	elif rng == 2:
		Type = EPOWERUPTYPE.ScoreFrenzy
	elif rng == 3:
		Type = EPOWERUPTYPE.SuperTimerUp
	elif rng == 4:
		Type = EPOWERUPTYPE.SuperScoreMult
	elif rng == 5:
		Type = EPOWERUPTYPE.ScreenNuke
	elif rng == 6:
		Type = EPOWERUPTYPE.FrezeTime
	

func set_idle_state():
	state = ESTATE.Idle
	timer = 5
	startOnLeft = not startOnLeft
	col.set_deferred("disabled", true)

func _on_area_entered(area: Area2D) -> void:
	if Type == EPOWERUPTYPE.TimerUp:
		hud.add_timer(50)
	elif Type == EPOWERUPTYPE.ScoreMult:
		var proj : ShootProjectile = area
		proj.scoreModifier = 10
	elif Type == EPOWERUPTYPE.ScoreFrenzy:
		manager.scoreFrenzyTimer = 10
	elif Type == EPOWERUPTYPE.ScoreFrenzy:
		manager.scoreFrenzyTimer = 10
	elif Type == EPOWERUPTYPE.SuperTimerUp:
		hud.add_timer(100)
	elif Type == EPOWERUPTYPE.SuperScoreMult:
		var proj : ShootProjectile = area
		proj.scoreModifier = 20
	elif Type == EPOWERUPTYPE.ScreenNuke:
		robotManager.nuke()
	elif Type == EPOWERUPTYPE.FrezeTime:
		robotManager.frezeTimer = 5
	
	set_idle_state()
