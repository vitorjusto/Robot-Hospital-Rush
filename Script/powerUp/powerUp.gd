extends Area2D

enum EPOWERUPTYPE{ TimerUp, ScoreMult, ScoreFrenzy, SuperTimerUp, SuperScoreMult}
enum ESTATE{ Idle, Running}
@export var Type : EPOWERUPTYPE
@onready var hud : Hud = get_tree().root.get_node("/root/Main/hud")
@onready var manager : fixersManager = get_tree().root.get_node("/root/Main/FixersManager")

var state : ESTATE = ESTATE.Idle
var timer = 5
var startOnLeft = true
var speed = 400
@onready var col : CollisionShape2D = get_node("CollisionShape2D")

@export var leftAnchor: Node2D
@export var rightAnchor: Node2D

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
	
	var rng = randi_range(0, 4)
	
	if rng == 0:
		Type = EPOWERUPTYPE.TimerUp
	elif rng == 1:
		Type = EPOWERUPTYPE.ScoreMult
	elif rng == 2:
		Type = EPOWERUPTYPE.ScoreFrenzy
	elif rng == 0:
		Type = EPOWERUPTYPE.SuperTimerUp
	elif rng == 1:
		Type = EPOWERUPTYPE.SuperScoreMult
	

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
	set_idle_state()
