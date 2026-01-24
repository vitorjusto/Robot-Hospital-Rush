extends Node2D

var isPaused = false
var pausedObjects = []
@onready var clPause : CanvasLayer = get_node("clPause")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		isPaused = !isPaused
		clPause.visible = isPaused
		if isPaused:
			PauseObjects(get_children())
		else:
			for i in pausedObjects:
				i.set_physics_process(true)
				i.set_process(true)
				if i is AnimatedSprite2D:
					var ani : AnimatedSprite2D = i
					ani.play()
				if i is AnimationPlayer:
					var ani : AnimationPlayer = i
					ani.play()
			
			pausedObjects.clear()
	

func PauseObjects(nodes : Array[Node]):
	for i in nodes:
		if i.process_mode == PROCESS_MODE_DISABLED:
			continue
		
		pausedObjects.append(i)
		i.set_physics_process(false)
		i.set_process(false)
		
		if i is AnimatedSprite2D:
			var ani : AnimatedSprite2D = i
			ani.pause()
			
		if i is AnimationPlayer:
			var ani : AnimationPlayer = i
			ani.pause()
		
		PauseObjects(i.get_children())
	
