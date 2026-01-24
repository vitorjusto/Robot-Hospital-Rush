extends CharacterBody2D
class_name Robot

var speed = Vector2(200, 100)
@export var size : int = 1

@onready var col : CollisionShape2D = get_node("CollisionShape2D")
var active = false
@onready var manager : RobotManager = get_tree().root.get_node("/root/Main/RobotManager")
@onready var main : Main = get_tree().root.get_node("/root/Main")

var timer = 20
var timer2 = 1

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	timer -= timer2 * delta / 2 if manager.frezeTimer > 0 else delta * timer2
	timer2 += delta * 0.02
	if timer < 0:
		modulate = Color.BLACK
		main.EndGame()
	elif timer < 10:
		modulate = Color.RED
	elif manager.frezeTimer > 0:
		modulate = Color.BLUE
	else:
		modulate = Color.WHITE
	
	velocity = speed / 2 if manager.frezeTimer > 0 else speed
	
	if move_and_slide():
		if is_on_wall():
			speed *= Vector2(-1, 1)
		if is_on_floor() or is_on_ceiling():
			speed *= Vector2(1, -1)
		

func defeat():
	setActive(false)

func setActive(v : bool):
	timer = 40
	active = v
	visible = active
	col.set_deferred("disabled", not active)
