tool
extends "res://Environment/MovingObject.gd"

onready var collision_shape = $CollisionShape2D
onready var animator = $AnimationPlayer

func _on_Area2D_body_entered(body):
	if body == PlayerStats.player:
		dissapear()
		
func dissapear():
	animator.play("FadeOut")
	
func appear():
	animator.play("FadeIn")
