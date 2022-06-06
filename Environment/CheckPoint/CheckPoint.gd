extends Node

var crow = preload("res://Environment/CheckPoint/Crow.tscn")

onready var animator = $AnimationPlayer

var gathered = false

func _ready():
	animator.play("Idle")

func _on_Area2D_body_entered(body):
	if body == Globals.player and !gathered:
		Globals.playerStats.last_checkpoint = position
		gathered = true
		
		add_child(crow.instance())
		
		animator.play("Collected")
