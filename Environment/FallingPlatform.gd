extends KinematicBody2D

export var time_to_start_falling = 0.5
export var destroy_time = 5

var is_falling = false
var velocity = Vector2.ZERO

func _physics_process(delta):
	if is_falling:
		velocity.y += Globals.player.gravity * delta
	
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body == Globals.player:
		yield(get_tree().create_timer(time_to_start_falling), "timeout")
		is_falling = true
		yield(get_tree().create_timer(destroy_time), "timeout")
		queue_free()
