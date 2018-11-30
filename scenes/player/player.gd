extends RigidBody2D

export (int) var speed = 10
export (float) var rotation_speed = 4.5

var velocity = Vector2()
var rotation_dir = 0

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

func _physics_process(delta):
	get_input()

	apply_impulse(Vector2($collision_shape.shape.extents.x / 2, 0.0), delta*Vector2(0.0, rotation_dir*rotation_speed))
	apply_impulse(Vector2(-$collision_shape.shape.extents.x / 2, 0.0), delta*Vector2(0.0, -rotation_dir*rotation_speed))

	apply_impulse(Vector2(0.0, 0.0), delta*velocity)