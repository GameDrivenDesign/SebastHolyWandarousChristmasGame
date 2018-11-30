extends RigidBody2D

export (int) var speed = 10
export (float) var rotation_speed = 4.5

var velocity = Vector2()
var rotation_dir = 0

var gift_count = 0

signal gift_count_changed(n)

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		rotation_dir += 1
	if Input.is_action_pressed('left'):
		rotation_dir -= 1
	if Input.is_action_pressed('down'):
		velocity = Vector2(0, speed).rotated(rotation)
	if Input.is_action_pressed('up'):
		velocity = Vector2(0, -speed).rotated(rotation)

	if Input.is_action_just_pressed('gift_projectile'):
		var mouse = get_global_mouse_position()
		var gift_direction = mouse - global_position
		var gift_projectile = preload('res://scenes/gift/gift_projectile.tscn').instance()
		gift_projectile.position = position
		gift_projectile.rotation = gift_direction.angle() + PI/2
		gift_projectile.apply_impulse(Vector2(0.0, 0.0), gift_direction)
		get_parent().add_child(gift_projectile)

func _physics_process(delta):
	get_input()

	apply_impulse(Vector2($collision_shape.shape.extents.x / 2, 0.0), delta*Vector2(0.0, rotation_dir*rotation_speed))
	apply_impulse(Vector2(-$collision_shape.shape.extents.x / 2, 0.0), delta*Vector2(0.0, -rotation_dir*rotation_speed))

	apply_impulse(Vector2(0.0, 0.0), delta*velocity)

func pickup_gift():
	gift_count += 1
	emit_signal("gift_count_changed", gift_count)
