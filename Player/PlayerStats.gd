extends "res://Player/Stats.gd"

onready var last_checkpoint = preload("res://Environment/CheckPoint/CheckPoint.tscn").instance()

func _ready():
	add_child(last_checkpoint)
	last_checkpoint.visible = false
	last_checkpoint.position = Vector2(0, 0)

