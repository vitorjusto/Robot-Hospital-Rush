extends CharacterBody2D


const SPEED = 1000.0
var fixersHolding : Array[fixer]
@onready var fixersManager : fixersManager = get_tree().root.get_node("/root/Main/FixersManager")

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("Left", "Right")
	
	velocity.x = move_toward(velocity.x, direction * SPEED, 100)

	move_and_slide()
	if Input.is_action_just_pressed("Get"):
		GetFixer()
	
	if Input.is_action_just_pressed("Shoot"):
		Shoot()
	
	handleFixers()

func GetFixer():
	if fixersHolding.size() == 10:
		return
	fixersHolding.push_back(fixersManager.getFixer(position.x))

func handleFixers():
	if fixersHolding.size() == 1:
		fixersHolding[0].position = position + Vector2(0, - 50)
	elif fixersHolding.size() == 2:
		fixersHolding[0].position = position + Vector2(-20, - 50)
		fixersHolding[1].position = position + Vector2(20, - 50)
	elif fixersHolding.size() == 3:
		fixersHolding[0].position = position + Vector2(-40, - 50)
		fixersHolding[1].position = position + Vector2(0, - 50)
		fixersHolding[2].position = position + Vector2(40, - 50)
	elif fixersHolding.size() == 4:
		fixersHolding[0].position = position + Vector2(-60, - 50)
		fixersHolding[1].position = position + Vector2(-20, - 50)
		fixersHolding[2].position = position + Vector2(20, - 50)
		fixersHolding[3].position = position + Vector2(60, - 50)
	elif fixersHolding.size() == 5:
		fixersHolding[0].position = position + Vector2(-80, - 50)
		fixersHolding[1].position = position + Vector2(-40, - 50)
		fixersHolding[2].position = position + Vector2(0, - 50)
		fixersHolding[3].position = position + Vector2(40, - 50)
		fixersHolding[4].position = position + Vector2(80, - 50)
	elif fixersHolding.size() == 6:
		fixersHolding[0].position = position + Vector2(-80, - 80)
		fixersHolding[1].position = position + Vector2(-40, - 80)
		fixersHolding[2].position = position + Vector2(0, - 80)
		fixersHolding[3].position = position + Vector2(40, - 80)
		fixersHolding[4].position = position + Vector2(80, - 80)
		
		fixersHolding[5].position = position + Vector2(0, - 50)
	elif fixersHolding.size() == 7:
		fixersHolding[0].position = position + Vector2(-80, - 80)
		fixersHolding[1].position = position + Vector2(-40, - 80)
		fixersHolding[2].position = position + Vector2(0, - 80)
		fixersHolding[3].position = position + Vector2(40, - 80)
		fixersHolding[4].position = position + Vector2(80, - 80)
		
		fixersHolding[5].position = position + Vector2(-20, - 50)
		fixersHolding[6].position = position + Vector2(20, - 50)
	elif fixersHolding.size() == 8:
		fixersHolding[0].position = position + Vector2(-80, - 80)
		fixersHolding[1].position = position + Vector2(-40, - 80)
		fixersHolding[2].position = position + Vector2(0, - 80)
		fixersHolding[3].position = position + Vector2(40, - 80)
		fixersHolding[4].position = position + Vector2(80, - 80)
		
		fixersHolding[5].position = position + Vector2(-40, - 50)
		fixersHolding[6].position = position + Vector2(0, - 50)
		fixersHolding[7].position = position + Vector2(40, - 50)
	elif fixersHolding.size() == 9:
		fixersHolding[0].position = position + Vector2(-80, - 80)
		fixersHolding[1].position = position + Vector2(-40, - 80)
		fixersHolding[2].position = position + Vector2(0, - 80)
		fixersHolding[3].position = position + Vector2(40, - 80)
		fixersHolding[4].position = position + Vector2(80, - 80)
		
		fixersHolding[5].position = position + Vector2(-60, - 50)
		fixersHolding[6].position = position + Vector2(-20, - 50)
		fixersHolding[7].position = position + Vector2(20, - 50)
		fixersHolding[8].position = position + Vector2(60, - 50)
	elif fixersHolding.size() == 10:
		fixersHolding[0].position = position + Vector2(-80, - 80)
		fixersHolding[1].position = position + Vector2(-40, - 80)
		fixersHolding[2].position = position + Vector2(0, - 80)
		fixersHolding[3].position = position + Vector2(40, - 80)
		fixersHolding[4].position = position + Vector2(80, - 80)
		
		fixersHolding[5].position = position + Vector2(-80, - 50)
		fixersHolding[6].position = position + Vector2(-40, - 50)
		fixersHolding[7].position = position + Vector2(0, - 50)
		fixersHolding[8].position = position + Vector2(40, - 50)
		fixersHolding[9].position = position + Vector2(80, - 50)

func Shoot():
	if fixersHolding.size() == 0:
		return
	
	fixersManager.shootProj(fixersHolding, position)
	fixersHolding.clear()
