extends Node

var playerInside = false

onready var label = $Label

func _ready():
	label.modulate.a = 0
	
func _process(_delta):
	if playerInside:
		label.modulate.a = lerp(label.modulate.a, 1, 0.1)
	else:
		label.modulate.a = lerp(label.modulate.a, 0, 0.1)

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		playerInside = true

func _on_Area2D_body_exited(body):
	if body == Globals.player:
		playerInside = false
