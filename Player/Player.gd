extends KinematicBody2D

export var gravity = 1000
export var acceleration = 1000
export var max_speed = 200
export var jump_force = 400
export var jump_decrease_on_release_coefficient = 2
export var slowdown_coefficient_ground = 0.5
export var slowdown_coefficient_air = 0.05
export var dash_force = 300

var velocity = Vector2.ZERO
var boots_active = false

var dash_direction = Vector2.ZERO
var can_dash = false
var dashing = false


onready var sprite = $Sprite

func _physics_process(delta):
	if Input.is_action_just_pressed("activate_boots"):
		boots_active = !boots_active
	
	dash()
	if !dashing:
		movement(delta)
	
func dash():
	if is_on_floor():
		can_dash = true
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dash_direction.x = -Input.get_action_strength("ui_left") + Input.get_action_strength("ui_right")
		dash_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		velocity = dash_direction * dash_force
		can_dash = false
		dashing = true
		yield(get_tree().create_timer(0.2), "timeout")
		dashing = false
	if dashing:
		velocity = move_and_slide(velocity)
		

func movement(delta):
	if boots_active:
		active_boots_movement(delta)
	else:
		unactive_boots_movement(delta)

func active_boots_movement(delta):
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

func unactive_boots_movement(delta):
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
