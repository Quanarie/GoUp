extends Node2D

onready var animator = $AnimationPlayer

func _ready():
	animator.play("Idle")

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		body.cat_bonuses += 1
		animator.play("Activate")
