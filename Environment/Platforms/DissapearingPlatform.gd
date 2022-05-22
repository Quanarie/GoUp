tool
extends "res://Environment/Platforms/MovingObject.gd"

onready var animator = $AnimationPlayer

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		dissapear()

func dissapear():
	animator.play("FadeOut")
	
func appear():
	animator.play("FadeIn")

