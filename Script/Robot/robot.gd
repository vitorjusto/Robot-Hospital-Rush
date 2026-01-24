extends CharacterBody2D
class_name Robot

var speed = Vector2(200, 100)
@export var size : int = 1

@onready var col : CollisionShape2D = get_node("CollisionShape2D")
var active = false

var timer = 40

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	timer -= delta
	
	if timer < 0:
		modulate = Color.BLACK
	elif timer < 10:
		modulate = Color.RED
	else:
		modulate = Color.WHITE
	
	velocity = speed
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
