extends Node

export var max_health = 1 setget set_max_health

var health = 1 setget set_health

signal no_health

func _ready():
	health = max_health

func set_max_health(value):
	max_health = value
	self.health = min(max_health, health)
	
func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
