extends Node

export var lifetime = 0.2

onready var animator = $AnimationPlayer

func _ready():
	animator.play("Idle")

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		body.can_dash = true
		animator.play("Activate")
