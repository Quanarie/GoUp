extends KinematicBody2D

export var jump_force = Vector2(0, 200)

onready var animator = $AnimationPlayer

var velocity = Vector2.ZERO

func _ready():
	animator.play("idle")

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		body.apply_force(jump_force)
		animator.play("apart")
	
func _on_AnimationPlayer_animation_finished(_apart):
	animator.play("idle")
	
