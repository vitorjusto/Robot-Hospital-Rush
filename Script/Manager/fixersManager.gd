extends Node2D
class_name fixersManager

@onready var fixers : Array[fixer]
@onready var fixerScene : PackedScene = load("res://Scenes/Fixers/Fixer.tscn")

@onready var projFixer : Array[ShootProjectile]
@onready var projFixerScene : PackedScene = load("res://Scenes/Fixers/ShootProjectile.tscn")

func _ready() -> void:
	for i in range(0, 10):
		addFixer()
	for i in range(0, 10):
		addProj()

func addFixer() -> fixer:
	var instance : fixer = fixerScene.instantiate()
	add_child(instance)
	fixers.append(instance)
	return instance
	
func addProj() -> ShootProjectile:
	var instance : ShootProjectile = projFixerScene.instantiate()
	add_child(instance)
	projFixer.append(instance)
	return instance

func getFixer(playerPosition : int) -> fixer:
	var inactive = fixers.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addFixer()
		
	instance.setActive(true)
	
	if(playerPosition > 1409.0):
		instance.changeType(fixer.EFixerType.BATTERY)
	elif(playerPosition > 961.0):
		instance.changeType(fixer.EFixerType.GEAR)
	elif(playerPosition > 513.0):
		instance.changeType(fixer.EFixerType.BOLT)
	else:
		instance.changeType(fixer.EFixerType.NUT)
	return instance

func shootProj(f : Array[fixer], pos: Vector2) -> ShootProjectile:
	var inactive = projFixer.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addProj()
		
	instance.setActive(true)
	instance.fixersHolding = f.duplicate()
	instance.position = pos
	
	return instance
