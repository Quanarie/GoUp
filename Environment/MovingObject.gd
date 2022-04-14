tool
extends KinematicBody2D

const IDLE_DURATION = 0.1

export var move_offset = Vector2.RIGHT * 100
export var duration = 3.0
export var is_turned = false   #if turned on -90 degrees

onready var tween = $MoveTween
onready var start_position = position

func _ready():
	if !Engine.is_editor_hint():
		set_tween(start_position, start_position + move_offset)
	
func set_tween(from, to):
	if move_offset == Vector2.ZERO:
		return
	tween.interpolate_property(self, "position", from, to, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "position", to, from, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION * 2)
	tween.start()

func _draw():
	if Engine.is_editor_hint():
		if is_turned:
			draw_line(Vector2.ZERO, Vector2(-move_offset.y, -move_offset.x), Color.lime, 2)
		else:
			draw_line(Vector2.ZERO, move_offset, Color.lime, 2)
