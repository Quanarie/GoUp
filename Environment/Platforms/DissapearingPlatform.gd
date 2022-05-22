tool
extends "res://Environment/Platforms/MovingObject.gd"

onready var animator = $AnimationPlayer
onready var animated_sprites = $AnimatedSprites

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		animator.play("FadeOut")

func animate_sprites():
	for i in animated_sprites.get_child_count():
		var sprite = animated_sprites.get_child(i)
		sprite.get_child(0).play("Dissolve")

func animate_sprites_reverse():
	for i in animated_sprites.get_child_count():
		var sprite = animated_sprites.get_child(i)
		sprite.get_child(0).play_backwards("Dissolve")
