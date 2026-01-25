extends CharacterBody2D
class_name Player

const SPEED = 1000.0
@onready var fixersManager : fixersManager = get_tree().root.get_node("/root/Main/FixersManager")
@onready var ani : AnimatedSprite2D = get_node("AnimatedSprite2D")

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("Left", "Right")
	
	if direction == 0:
		ani.play("Idle")
	else:
		ani.play("Walk")
	velocity.x = move_toward(velocity.x, direction * SPEED, 100)

	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot"):
		Shoot()

func Shoot():
	fixersManager.shootProj(position)
