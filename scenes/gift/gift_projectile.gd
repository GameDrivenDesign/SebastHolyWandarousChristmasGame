extends RigidBody2D

var min_speed_till_normal_gift_spawn = 0.01

func _physics_process(delta):
	return
	#if velocity.length() < min_speed_till_normal_gift_spawn:
	#	var new_gift = preload('res://scenes/gift/gift.tscn').instance()
	#	add_node(new_gift)
	#	queue_free()