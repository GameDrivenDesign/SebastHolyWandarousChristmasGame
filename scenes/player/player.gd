extends RigidBody2D

export (int) var speed = 10
export (float) var rotation_speed = 4.5

var velocity = Vector2()
var rotation_dir = 0

var gift_count = 0

var target_line = Line2D.new()


var reins1_line = Line2D.new()
var reins2_line = Line2D.new()

signal gift_count_changed(n)

func _ready():
	target_line.add_point(Vector2(0.0, 0.0))
	target_line.add_point(Vector2(0.0, 0.0))
	add_child(target_line)
	
	reins1_line.add_point(Vector2(0.0, 0.0))
	reins1_line.add_point(Vector2(0.0, 0.0))
	reins2_line.add_point(Vector2(0.0, 0.0))
	reins2_line.add_point(Vector2(0.0, 0.0))
	add_child(reins1_line)
	add_child(reins2_line)
	
	#$sled_loop

func _process(delta):
	var target_volume = velocity.length() - 8
	$sled_loop.volume_db = $sled_loop.volume_db * (1.0 - delta*10) + target_volume * delta*10
	
	var target_pitch_scale = 1 + (velocity.length() / speed) / 4
	$sled_loop.pitch_scale = $sled_loop.pitch_scale * (1.0 - delta*5) + target_pitch_scale * delta*5
	
	var mouse = get_global_mouse_position()
	target_line.set_global_position(Vector2(0.0, 0.0))
	target_line.rotation = -rotation
	target_line.set_point_position(0, position)
	target_line.set_point_position(1, mouse)
	
	var distance = (mouse - position).length()
	
	target_line.default_color = Color(float(gift_count <= 0) * 0.8, float(gift_count > 0) * 0.8, 0.0, clamp(0.001 * distance, 0.0, 0.6))
	
	var reins1_start = $RigidBody2D/pos_con_santa_l.global_position - position
	var reins2_start = $RigidBody2D/pos_con_santa_r.global_position - position
	var reins_end = $pos_con_deer.global_position - position
	
	reins1_line.rotation = -rotation
	reins2_line.rotation = -rotation
	
	reins1_line.set_point_position(0, reins1_start)
	reins1_line.set_point_position(1, reins_end)
	reins2_line.set_point_position(0, reins2_start)
	reins2_line.set_point_position(1, reins_end)
	
	reins1_line.default_color = Color(0.0, 0.0, 0.0)
	reins1_line.width = 1
	reins2_line.default_color = Color(0.0, 0.0, 0.0)
	reins2_line.width = 1

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

	if Input.is_action_just_pressed('gift_projectile') and gift_count > 0:
		var mouse = get_global_mouse_position()
		var gift_direction = mouse - global_position
		var gift_projectile = preload('res://scenes/gift/gift_projectile.tscn').instance()
		gift_projectile.position = position
		gift_projectile.rotation = gift_direction.angle() + PI/2
		gift_projectile.apply_impulse(Vector2(0.0, 0.0), gift_direction * 5)
		get_parent().add_child(gift_projectile)
		
		gift_count -= 1
		emit_signal("gift_count_changed", gift_count)

func _physics_process(delta):
	get_input()

	apply_impulse(Vector2($collision_shape.shape.extents.x / 2, 0.0), delta*Vector2(0.0, rotation_dir*rotation_speed))
	apply_impulse(Vector2(-$collision_shape.shape.extents.x / 2, 0.0), delta*Vector2(0.0, -rotation_dir*rotation_speed))

	apply_impulse(Vector2(0.0, 0.0), delta*velocity)

func pickup_gift():
	gift_count += 1
	emit_signal("gift_count_changed", gift_count)
