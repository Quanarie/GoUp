extends Node2D

export var speed = 200
export var alive_time = 15
export var bound_angle = 20

var velocity = Vector2.ZERO

var direction = Vector2.ZERO

func _ready():
	randomize()
	var x = rand_range(cos(PI * (90 - bound_angle) / 180), cos(PI * bound_angle / 180))
	var y = sqrt(1 - pow(x, 2))
	direction = Vector2(x, -y)
	velocity = direction * speed
	if Globals.player.position.x >= global_position.x:
		velocity.x *= -1
		$AnimatedSprite.flip_h = true
	yield(get_tree().create_timer(alive_time), "timeout")
	queue_free()

func _physics_process(delta):
	position += velocity * delta
