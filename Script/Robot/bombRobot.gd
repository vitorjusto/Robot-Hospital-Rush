extends Area2D

enum ESTATE{ Idle, Running, Exploding}
@onready var hud : Hud = get_tree().root.get_node("/root/Main/hud")
@onready var manager : fixersManager = get_tree().root.get_node("/root/Main/FixersManager")
@onready var robotManager : RobotManager = get_tree().root.get_node("/root/Main/RobotManager")

var state : ESTATE = ESTATE.Idle
var timer = 30
var explodingTimer = 2
var score = 0
var startOnLeft = true
var speed = 600
@onready var col : CollisionShape2D = get_node("CollisionShape2D")
@onready var exCol : CollisionShape2D = get_node("ExplodingArea/CollisionShape2D")

@export var leftAnchor: Node2D
@export var rightAnchor: Node2D

func _process(delta: float) -> void:
	if state == ESTATE.Idle:
		timer -= delta
		if timer <= 0:
			set_running_state()
	elif state == ESTATE.Exploding:
		explodingTimer -= delta
		if explodingTimer < 0:
			set_idle_state()
	else:
		position.x += speed * delta / (2 if robotManager.frezeTimer > 0 else 1)
		if position.x < leftAnchor.position.x or position.x > rightAnchor.position.x:
			set_idle_state()
		

func set_running_state():
	col.set_deferred("disabled", false)
	state = ESTATE.Running
	if startOnLeft:
		position = leftAnchor.position
		speed = 600
	else:
		position = rightAnchor.position
		speed = -600
	exCol.set_deferred("disabled", true)

func set_idle_state():
	state = ESTATE.Idle
	timer = 30
	startOnLeft = not startOnLeft
	col.set_deferred("disabled", true)
	exCol.set_deferred("disabled", true)

func set_exploding_state():
	state = ESTATE.Exploding
	exCol.set_deferred("disabled", false)
	col.set_deferred("disabled", true)
	explodingTimer = 2

func _on_area_entered(area: Area2D) -> void:
	set_exploding_state()


func onRobotDetected(body: Node2D) -> void:
	score += 100 
	hud.add_score(score * manager.streak)
	var robot : Robot = body
	robot.setActive(false)
	
