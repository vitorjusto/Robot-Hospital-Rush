extends AnimatedSprite2D
class_name fixer

var active = false

enum EFixerType {NUT, BOLT, GEAR, BATTERY} 
var type : EFixerType;

func _ready() -> void:
	setActive(false)

func setActive(value : bool):
	active = value
	visible = value

func changeType(t : EFixerType):
	type = t
	
	if type == EFixerType.NUT:
		modulate = Color.BLACK
	elif type == EFixerType.BOLT:
		modulate = Color.YELLOW
	elif type == EFixerType.GEAR:
		modulate = Color.RED
	elif type == EFixerType.BATTERY:
		modulate = Color.BLUE
