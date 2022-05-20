extends Node2D

export var pieces_quantity = 5
export var speed = 3
export var bound_degree = 0

onready var sprite = $Sprite
onready var hitbox = $Hitbox
onready var offset = Vector2(0, piece.instance().get_rect().size.y * pieces_quantity - 45)

var piece = preload("res://Environment/Obstacles/Demonaxe/ChainPiece.tscn")
var end_piece = preload("res://Environment/Obstacles/Demonaxe/ChainEnd.tscn")

var sinArgument = 0

func _ready():
	var spawn_point = Vector2(0, -piece.instance().get_rect().size.y / 2)
	for _i in range(0, pieces_quantity):
		var new_piece = piece.instance()
		sprite.add_child(new_piece)
		new_piece.position = spawn_point
		spawn_point.y -= new_piece.get_rect().size.y
	
	var last_piece = end_piece.instance()
	sprite.add_child(last_piece)
	spawn_point.y += piece.instance().get_rect().size.y - 20
	last_piece.position = spawn_point
	position -= offset
	for child in get_children():
		child.position -= spawn_point

func _physics_process(delta):
	rotation = sin(sinArgument) * PI * bound_degree / 360
	sinArgument += delta * speed
