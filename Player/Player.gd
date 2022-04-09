extends KinematicBody2D

export var gravity = 1000
export var acceleration = 1000
export var max_speed = 200
export var jump_force = 400
export var jump_decrease_on_release_coefficient = 2
export var slowdown_coefficient_ground = 0.5
export var slowdown_coefficient_air = 0.05
export var boots_active = false

var velocity = Vector2.ZERO

onready var sprite = $Sprite

func _physics_process(delta):
	if Input.is_action_just_pressed("activate_boots"):
		if boots_active: boots_active = false
		else: boots_active = true
	
	if boots_active:
		rotation_degrees = -90
		velocity.x += gravity * delta
		
		var apply_friction = false
		
		if Input.is_action_pressed("ui_up"):
			if velocity.y > 0:
				velocity.y *= (1 - slowdown_coefficient_ground)   #helps to change direction faster
			velocity.y = max(velocity.y - acceleration * delta, -max_speed)
			sprite.flip_h = false
		elif Input.is_action_pressed("ui_down"):
			if velocity.y < 0:
				velocity.y *= (1 - slowdown_coefficient_ground)
			velocity.y = min(velocity.y + acceleration * delta, max_speed)
			sprite.flip_h = true
		else:
			apply_friction = true
		
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				velocity.x -= jump_force
			if apply_friction:
				velocity.y = lerp(velocity.y, 0, slowdown_coefficient_ground)
		else:
			if Input.is_action_just_released("jump"):
				if velocity.x < 0:
					velocity.x /= jump_decrease_on_release_coefficient
			
		if not is_on_floor() and apply_friction:
			velocity.y = lerp(velocity.y, 0, slowdown_coefficient_air)
		
		velocity = move_and_slide(velocity, Vector2.LEFT)
	else:
		rotation_degrees = 0
		velocity.y += gravity * delta
		
		var apply_friction = false
		
		if Input.is_action_pressed("ui_right"):
			if velocity.x < 0:
				velocity.x *= (1 - slowdown_coefficient_ground)   #helps to change direction faster
			velocity.x = min(velocity.x + acceleration * delta, max_speed)
			sprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			if velocity.x > 0:
				velocity.x *= (1 - slowdown_coefficient_ground)
			velocity.x = max(velocity.x - acceleration * delta, -max_speed)
			sprite.flip_h = true
		else:
			apply_friction = true
		
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				velocity.y -= jump_force
			if apply_friction:
				velocity.x = lerp(velocity.x, 0, slowdown_coefficient_ground)
		else:
			if Input.is_action_just_released("jump"):
				if velocity.y < 0:
					velocity.y /= jump_decrease_on_release_coefficient
			
		if not is_on_floor() and apply_friction:
			velocity.x = lerp(velocity.x, 0, slowdown_coefficient_air)
		
		velocity = move_and_slide(velocity, Vector2.UP)
