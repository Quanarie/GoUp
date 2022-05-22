extends KinematicBody2D

export var respawn_time = 5

var velocity = Vector2.ZERO
var is_triggered = false

onready var animator = $AnimationPlayer
onready var start_pos = global_position

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	velocity.y += Globals.player.gravity * delta
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if !is_triggered and body == Globals.player:
		is_triggered = true
		animator.play("Shake")
		velocity = Vector2.ZERO

func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(true)
	yield(get_tree().create_timer(respawn_time), "timeout")
	set_physics_process(false)
	yield(get_tree(), "physics_frame")
	var temp = collision_layer
	collision_layer = 0
	global_position = start_pos
	yield(get_tree(), "physics_frame")
	collision_layer = temp
	is_triggered = false
