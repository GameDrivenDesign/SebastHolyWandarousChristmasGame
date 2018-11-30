extends KinematicBody2D

export (int) var max_speed = 200
export (int) var min_distance = 600

var velocity = Vector2()

var player

func _ready():
	player = get_parent().get_parent().get_node("player")

func _process(delta):
	velocity = Vector2(0.0, 0.0)
	
	var target_position = player.position
	var direction = (target_position - position)
	
	var speed = ((min_distance - direction.length()) / min_distance) * max_speed
	
	velocity = float(direction.length() <= min_distance) * direction.normalized() * speed
	
	rotation = direction.angle()

func _physics_process(delta):
	move_and_collide(delta*velocity)