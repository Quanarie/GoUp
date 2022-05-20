tool
extends "res://Environment/Platforms/MovingObject.gd"

onready var collision_shape = $CollisionShape2D
onready var animator = $AnimationPlayer
onready var collider = $Area2D

func _physics_process(_delta):
	if collider.overlaps_body(Globals.player) and !animator.is_playing():
		dissapear()

func dissapear():
	animator.play("FadeOut")
	
func appear():
	animator.play("FadeIn")
