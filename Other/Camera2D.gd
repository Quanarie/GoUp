extends Camera2D

export var shake_time = 0.1
export var shake_strength = 2

var elapsed_time = 0.0
var isShaking = false

func _ready():
	randomize()
	Globals.camera = self

func _physics_process(delta):
	if isShaking:
		if elapsed_time < shake_time:
			offset =  Vector2(randf(), randf()) * shake_strength
			elapsed_time += delta
		else:
			elapsed_time = 0
			isShaking = false

func shake():
	isShaking = true
