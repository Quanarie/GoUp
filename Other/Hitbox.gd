extends Area2D

export var damage = 1
export var recharge_time = 1
export var mask_hurtbox_number = 0

func recharge():
	set_collision_mask_bit(mask_hurtbox_number, false)
	yield(get_tree().create_timer(recharge_time), "timeout")
	set_collision_mask_bit(mask_hurtbox_number, true)
