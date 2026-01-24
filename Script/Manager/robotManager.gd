extends Node2D
class_name RobotManager

@onready var robot : Array[Robot]
@onready var robotScene : PackedScene = load("res://Scenes/Robot/Robot.tscn")

@export var leftAnchor : Array[Node2D]
@export var rightAnchor : Array[Node2D]
@export var topAnchor : Array[Node2D]
@export var hud : Hud

var timer = 70
var timerModifier = 1

var frezeTimer = 0
func _ready() -> void:
	for i in range(0, 200):
		addNewRobot()

func resetManager():
	for i in robot:
		i.reset()
	
	timer = 70
	timerModifier = 1
	frezeTimer = 0

func _process(delta: float) -> void:
	timer -= delta * 60 * timerModifier
	timerModifier += delta * 0.02
	if timer <= 0:
		addRobot()
		timer = 70
	
	if frezeTimer > 0:
		frezeTimer -= delta
	

func addNewRobot() -> Robot:
	var instance : Robot = robotScene.instantiate()
	add_child(instance)
	robot.append(instance)
	return instance

func addRobot():
	var inactive = robot.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		return
	
	instance.setActive(true)
	
	var rng = randi_range(1, 3)
	
	if rng == 1:
		var anchor = leftAnchor[randi_range(0, leftAnchor.size() - 1)]
		instance.position = anchor.position
		instance.speed = Vector2(70 * timerModifier, randf_range(-30, 30))
	elif rng == 2:
		var anchor = rightAnchor[randi_range(0, rightAnchor.size() - 1)]
		instance.position = anchor.position
		instance.speed = Vector2(-70 * timerModifier, randf_range(-30, 30))
	else:
		var anchor = topAnchor[randi_range(0, topAnchor.size() - 1)]
		instance.position = anchor.position
		instance.speed = Vector2(randf_range(-30, 30), 70 * timerModifier)


func nuke():
	var actives = robot.filter(func(x): return x.active)
	var score = 0
	
	for r in actives:
		r.setActive(false)
		score += 100
		hud.add_score(score)

func deactivateEveryRobot():
	var actives = robot.filter(func(x): return x.active)
	for r in actives:
		r.setActive(false)
