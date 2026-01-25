extends Node2D
class_name fixersManager

@onready var projFixer : Array[ShootProjectile]
@onready var projFixerScene : PackedScene = load("res://Scenes/Fixers/ShootProjectile.tscn")

var scoreFrenzyTimer = 0
var streak = 1

func resetManager():
	streak = 1
	scoreFrenzyTimer = 0
	for i in projFixer:
		i.setActive(false)

func _ready() -> void:
	for i in range(0, 30):
		addProj()

func _process(delta : float):
	if scoreFrenzyTimer > 0:
		scoreFrenzyTimer -= delta

func addProj() -> ShootProjectile:
	var instance : ShootProjectile = projFixerScene.instantiate()
	add_child(instance)
	projFixer.append(instance)
	return instance

func shootProj(pos: Vector2) -> ShootProjectile:
	var inactive = projFixer.filter(func(x): return not x.active)
	var instance = inactive[0] if inactive.size() > 0 else null
	
	if instance == null:
		instance = addProj()
		
	instance.setActive(true)
	instance.position = pos
	
	if scoreFrenzyTimer > 0:
		instance.scoreModifier = 2
	
	return instance
