extends KinematicBody2D

const IDLE_DURATION = 0.1

export var move_offset = Vector2.RIGHT * 100
export var duration = 3.0

onready var tween = $MoveTween
onready var start_position = position

func _ready():
	set_tween(start_position, start_position + move_offset)
	
func set_tween(from, to):
	tween.interpolate_property(self, "position", from, to, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "position", to, from, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION * 2)
	tween.start()

func _on_MoveTween_tween_all_completed():
	set_tween(start_position, start_position + move_offset)
