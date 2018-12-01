extends KinematicBody2D

export (int) var max_speed = 200
export (int) var min_distance = 600

export (int) var deadly_speed = 350

var velocity = Vector2()
export (bool) var alive = true

var player

export (bool) var is_good_kid = true

signal is_done(name, is_good_kid, got_present)

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
	
	$name_container.rotation = -rotation

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.collider
		if "players" in collider.get_groups() or "coal_projectile" in collider.get_groups():
			var collision_point = collision_info.position
			var speed = (collision_info.collider_velocity - velocity).length()
			if speed >= deadly_speed:
				$collision_shape.disabled = true
				$placeholder_rect.color = Color(0.8, 0, 0)
				alive = false
				emit_signal("is_done", $name_container/name.text, is_good_kid, false)
		if "gift_projectiles" in collider.get_groups():
			var collision_point = collision_info.position
			var speed = (collision_info.collider_velocity - velocity).length()
			$collision_shape.disabled = true
			$placeholder_rect.color = Color(0.0, 0.8, 0)
			alive = false
			collider.queue_free()
			emit_signal("is_done", $name_container/name.text, is_good_kid, true)

func set_name(name):
	$name_container/name.text = name

func get_name():
	return $name_container/name.text

func set_is_good_kid(is_good):
	is_good_kid = is_good