extends Node

export var speed_up_coefficient = 5

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		body.velocity *= speed_up_coefficient
		body.max_speed.x.x *= speed_up_coefficient


func _on_Area2D_body_exited(body):
	if body == Globals.player:
		body.max_speed.x.x /= speed_up_coefficient
