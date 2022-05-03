extends Node2D

var gathered = false

func _on_Area2D_body_entered(body):
	if body == Globals.player and !gathered:
		Globals.playerStats.last_checkpoint = position
		gathered = true
