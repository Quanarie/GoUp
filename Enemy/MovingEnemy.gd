tool
extends "res://Environment/Platforms/MovingObject.gd"

onready var sprite = $Sprite
onready var stats = $Stats
onready var animator = $AnimationPlayer

func _ready():
	stats.connect("no_health", self, "death")
	_on_AnimationPlayer_animation_finished("")
		
func _on_MoveTween_tween_completed(_object, _key):
	sprite.flip_h = !sprite.flip_h

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	area.recharge()
	if stats.health > 0:
		animator.play("Damage")

func _on_AnimationPlayer_animation_finished(_anim_name):
	if move_offset != Vector2.ZERO:
		animator.play("Move")
	else:
		animator.play("Idle")

func death():
	animator.play("Death")
