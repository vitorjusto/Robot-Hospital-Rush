extends Node2D

@onready var robot : Array[Robot]
@onready var robotScene : PackedScene = load("res://Scenes/Robot/Robot.tscn")

@export var leftAnchor : Array[Node2D]
@export var rightAnchor : Array[Node2D]
@export var topAnchor : Array[Node2D]

var timer = 100

func _ready() -> void:
	for i in range(0, 50):
		addNewRobot()

func _process(delta: float) -> void:
	timer -= delta * 60
	
	if timer <= 0:
		addRobot()
		timer = 100
	

func addNewRobot() -> Robot:
	var instance : Robot = robotScene.instantiate()
	add_child(instance)
	robot.append(instance)
	return instance

func addRobot():
	var inactive = robot.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addNewRobot()
		
	instance.setActive(true)
	instance.changeType()
	
	var rng = randi_range(1, 3)
	
	if rng == 1:
		var anchor = leftAnchor[randi_range(0, leftAnchor.size() - 1)]
		instance.position = anchor.position
		instance.speed = Vector2(50, randf_range(-50, 50))
	elif rng == 2:
		var anchor = rightAnchor[randi_range(0, rightAnchor.size() - 1)]
		instance.position = anchor.position
		instance.speed = Vector2(-50, randf_range(-50, 50))
	else:
		var anchor = topAnchor[randi_range(0, topAnchor.size() - 1)]
		instance.position = anchor.position
		instance.speed = Vector2(randf_range(-50, 50), 50)
		
	
