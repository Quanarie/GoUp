extends KinematicBody2D

export var jump_force = Vector2(0, 200)

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		body.apply_force(jump_force)
