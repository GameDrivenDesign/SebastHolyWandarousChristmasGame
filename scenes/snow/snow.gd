extends Node2D

func _ready():
	if OS.has_feature('JavaScript'):
		$Particles2D.queue_free()