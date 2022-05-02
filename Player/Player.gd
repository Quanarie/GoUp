extends KinematicBody2D

export var gravity = 1000
export var acceleration = 1000
export var max_speed = 200

export var jump_force = 400
export var jump_decrease_on_release_coefficient = 2

export var slowdown_coefficient_ground = 0.8
export var slowdown_coefficient_air = 0.07

export var dash_force = 250
export var dash_duration = 0.2 

var velocity = Vector2.ZERO
var boots_active = false

var dash_direction = Vector2.ZERO
var can_dash = false
var dashing = false
var is_dash_animation_ended = true

var attacking = false

onready var sprite = $Sprite
onready var stats = PlayerStats
onready var animationTree = $AnimationTree

func _ready():
	stats.connect("no_health", self, "death")
	animationTree.active = true
	stats.player = self

func _physics_process(delta):
	print(velocity)
	if Input.is_action_just_pressed("activate_boots"):
		if !boots_active: velocity.x = 0
		else: velocity.y = 0
		boots_active = !boots_active
		
	if Input.is_action_just_pressed("attack"):
		animationTree.set("parameters/State/current", 2)
		attacking = true
	
	dash()
	if !dashing:
		movement(delta)
	
func dash():
	if is_on_floor():
		can_dash = true
	
	var input = Vector2.ZERO
	input.x = -Input.get_action_strength("ui_left") + Input.get_action_strength("ui_right")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input != Vector2.ZERO:
		dash_direction = input
	elif boots_active:
		dash_direction = Vector2(-1, 0)
	else:
		dash_direction = Vector2(0, -1)
		
	if Input.is_action_just_pressed("dash") and can_dash and !is_on_floor():
		if dash_direction != Vector2.ZERO:
			is_dash_animation_ended = false
			animationTree.set("parameters/State/current", 3)
			velocity = dash_direction.normalized() * dash_force
			can_dash = false
			dashing = true
			yield(get_tree().create_timer(dash_duration), "timeout")
			dashing = false
	if dashing:
		if input != Vector2.ZERO:
			velocity = lerp(velocity, input * dash_force, 0.05)
		velocity = move_and_slide(velocity)

func movement(delta):
	if is_dash_animation_ended:
		if is_on_floor() and !attacking:
			animationTree.set("parameters/State/current", 0)
		elif !attacking:
			animationTree.set("parameters/State/current", 1)
		
		if (boots_active and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")) or
			!boots_active and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"))):
				animationTree.set("parameters/Movement/current", 1)
		else:
			animationTree.set("parameters/Movement/current", 0)
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			animationTree.set("parameters/InAir/current", 0)

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
		sprite.flip_h = true
	elif Input.is_action_pressed("ui_down"):
		if velocity.y < 0:
			velocity.y *= (1 - slowdown_coefficient_ground)
		velocity.y = min(velocity.y + acceleration * delta, max_speed)
		sprite.flip_h = false
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
		sprite.flip_h = true
	elif Input.is_action_pressed("ui_left"):
		if velocity.x > 0:
			velocity.x *= (1 - slowdown_coefficient_ground)
		velocity.x = max(velocity.x - acceleration * delta, -max_speed)
		sprite.flip_h = false
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

func death():
	stats.health = stats.max_health
	position = Vector2.ZERO

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	area.recharge()

func _on_attack_animation_ended():
	attacking = false

func _on_air_animation_ended():
	animationTree.set("parameters/InAir/current", 1)
	
func _on_dash_animation_ended():
	is_dash_animation_ended = true
