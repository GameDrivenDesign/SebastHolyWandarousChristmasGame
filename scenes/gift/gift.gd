extends Node2D

const images = [
	preload("res://scenes/gift/gift1.svg"),
	preload("res://scenes/gift/gift2.svg"),
	preload("res://scenes/gift/gift3.svg")
]

func _ready():
	$Sprite.set_texture(images[randi() % images.size()])

func _on_body_entered(body):
	if body.is_in_group("players"):
		print("Gift picked up")
		body.pickup_gift()
		queue_free()