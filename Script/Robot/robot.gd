extends CharacterBody2D
class_name Robot

var speed = Vector2(200, 100)
@export var type : fixer.EFixerType
@export var size : int

func _physics_process(delta: float) -> void:
	velocity = speed
	if move_and_slide():
		if is_on_wall():
			speed *= Vector2(-1, 1)
		if is_on_floor() or is_on_ceiling():
			speed *= Vector2(1, -1)
		

func defeat():
	call_deferred("queue_free")
	
