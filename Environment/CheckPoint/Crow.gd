extends Node2D

export var speed = 100
export var alive_time = 15

var velocity = Vector2.ZERO

onready var direction = Vector2(rand_range(-1, 1), rand_range(-1, 0))

func _ready():
	randomize()
	velocity = direction * speed
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	yield(get_tree().create_timer(alive_time), "timeout")
	queue_free()

func _physics_process(delta):
	position += velocity * delta
