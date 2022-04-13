extends Area2D

export var damage = 1
export var recharge_time = 1

func recharge():
	set_collision_mask_bit(3, false)
	yield(get_tree().create_timer(recharge_time), "timeout")
	set_collision_mask_bit(3, true)
