tool
extends "res://Environment/Platforms/MovingObject.gd"

onready var collision_shape = $CollisionShape2D
onready var animator = $AnimationPlayer

func _on_Area2D_body_entered(body):
	if body == Globals.player and !animator.is_playing():
		dissapear()
		
func dissapear():
	animator.play("FadeOut")
	
func appear():
	animator.play("FadeIn")
