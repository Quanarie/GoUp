extends "res://Environment/MovingObject.gd"

onready var sprite = $Sprite

func _on_MoveTween_tween_completed(object, key):
	sprite.flip_h = !sprite.flip_h
