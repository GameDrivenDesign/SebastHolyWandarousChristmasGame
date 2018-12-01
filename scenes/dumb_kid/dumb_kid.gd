extends KinematicBody2D

export (int) var max_speed = 200
export (int) var min_distance = 600

export (int) var deadly_speed = 350

var velocity = Vector2()
var alive = true

var player

var is_good_kid = true

signal is_done(name, success)

func _ready():
	player = get_parent().get_parent().get_node("player")

func _process(delta):
	velocity = Vector2(0.0, 0.0)
	
	if !alive:
		return
	
	var target_position = player.position
	var direction = (target_position - position)
	
	var speed = ((min_distance - direction.length()) / min_distance) * max_speed
	
	velocity = float(direction.length() <= min_distance) * direction.normalized() * speed
	
	look_at(player.position)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.collider
		if "players" in collider.get_groups():
			var collision_point = collision_info.position
			var speed = (collision_info.collider_velocity - velocity).length()
			if speed >= deadly_speed:
				$collision_shape.disabled = true
				$placeholder_rect.color = Color(0.8, 0, 0)
				alive = false
				emit_signal("is_done", $name.text, false)
		if "gift_projectiles" in collider.get_groups():
			var collision_point = collision_info.position
			var speed = (collision_info.collider_velocity - velocity).length()
			$collision_shape.disabled = true
			$placeholder_rect.color = Color(0.0, 0.8, 0)
			alive = false
			collider.queue_free()
			emit_signal("is_done", $name.text, is_good_kid)

		# TODO: If hit by coal
		# emit_signal("is_done", $name.text, not is_good_kid)

func set_name(name):
	$name.text = name

func set_is_good_kid(is_good):
	is_good_kid = is_good