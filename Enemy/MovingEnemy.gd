tool
extends "res://Environment/MovingObject.gd"

onready var sprite = $Sprite
onready var stats = $Stats

func _ready():
	stats.connect("no_health", self, "death")

func _on_MoveTween_tween_completed(_object, _key):
	sprite.flip_h = !sprite.flip_h

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	area.recharge()

func death():
	queue_free()
