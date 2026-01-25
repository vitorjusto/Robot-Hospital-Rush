extends Node2D
class_name ScoreLabel

var active
@onready var lbl : Label = get_node("Node2D/lblScore")
@onready var scoreExplosion : Sprite2D = get_node("Node2D/ScoreExplosion")
@onready var ani : AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	setActive(false)

func setActive(v : bool):
	active = v
	visible = v
	
	if active:
		ani.play("new_animation")

func setScore(score : int):
	lbl.text = "%d" % score
	if score < 50:
		scoreExplosion.modulate = Color.WHITE
		lbl.modulate = Color.BLACK
	elif score < 100:
		scoreExplosion.modulate = Color.YELLOW
		lbl.modulate = Color.BLACK
	elif score < 500:
		scoreExplosion.modulate = Color.ORANGE
		lbl.modulate = Color.WHITE
	elif score < 1000:
		scoreExplosion.modulate = Color.RED
		lbl.modulate = Color.WHITE
	else:
		scoreExplosion.modulate = Color.RED
		lbl.modulate = Color.YELLOW
	
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	setActive(false)
