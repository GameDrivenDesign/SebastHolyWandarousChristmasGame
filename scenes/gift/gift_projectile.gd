extends RigidBody2D

var min_speed_till_normal_gift_spawn = 0.4

func _physics_process(delta):
	if linear_velocity.length() < min_speed_till_normal_gift_spawn and angular_velocity < min_speed_till_normal_gift_spawn:
		var new_gift = preload('res://scenes/gift/gift.tscn').instance()
		new_gift.position = position
		new_gift.rotation = rotation
		get_parent().add_child(new_gift)
		queue_free()
		print("changed gift projectile into regular gift")