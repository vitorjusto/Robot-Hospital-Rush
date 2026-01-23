extends Area2D
class_name ShootProjectile

var active = false
var speed = 1100
var fixersHolding : Array[fixer]

func _physics_process(delta: float) -> void:
	if not active:
		return;
	
	position += Vector2(0, -speed) * delta
	
	handleFixers()
	

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

func setActive(value : bool):
	active = value
	visible = value


func onScreenExited() -> void:
	for f in fixersHolding:
		f.setActive(false)
	
	fixersHolding.clear()
	setActive(false)


func onRobotDetected(body: Node2D) -> void:
	var robot : Robot = body
	
	var elegibleFixers = fixersHolding.filter(func(x): return x.type == robot.type)
	
	if elegibleFixers.is_empty():
		return
	
	if robot.size > elegibleFixers.size():
		robot.size -= elegibleFixers.size()
	elif robot.size < elegibleFixers.size():
		elegibleFixers.pop_at(robot.size)
		robot.defeat()
	else:
		robot.defeat()
	
	for i in elegibleFixers:
		fixersHolding.erase(i)
		i.setActive(false)
	
	if fixersHolding.is_empty():
		setActive(false)
