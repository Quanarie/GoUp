extends Node2D

var crow = preload("res://Environment/CheckPoint/Crow.tscn")

onready var animator = $AnimationPlayer

var gathered = false
var is_turned = false

func _ready():
	animator.play("Idle")
	if is_equal_approx(rotation_degrees, -90):
		is_turned = true

func _on_Area2D_body_entered(body):
	if body == Globals.player and !gathered:
		Globals.playerStats.last_checkpoint = self
		gathered = true
		
		add_child(crow.instance())
		
		animator.play("Collected")
