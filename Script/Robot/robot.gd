extends CharacterBody2D
class_name Robot

var speed = Vector2(200, 100)
@export var type : fixer.EFixerType
@export var size : int = 1

@onready var col : CollisionShape2D = get_node("CollisionShape2D")
var active = false

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	velocity = speed
	if move_and_slide():
		if is_on_wall():
			speed *= Vector2(-1, 1)
		if is_on_floor() or is_on_ceiling():
			speed *= Vector2(1, -1)
		

func defeat():
	setActive(false)

func setActive(v : bool):
	active = v
	visible = active
	col.set_deferred("disabled", not active)

func changeType():
	var rng = randi_range(1, 4)
	
	if rng == 1:
		type = fixer.EFixerType.NUT
		modulate = Color.BLACK
	elif rng == 2:
		type = fixer.EFixerType.BOLT
		modulate = Color.GREEN
	elif rng == 3:
		type = fixer.EFixerType.GEAR
		modulate = Color.RED
	else:
		type = fixer.EFixerType.BATTERY
		modulate = Color.BLUE
