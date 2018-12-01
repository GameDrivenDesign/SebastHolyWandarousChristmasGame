extends Button

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _pressed():
	get_tree().change_scene("res://scenes/world/world.tscn")