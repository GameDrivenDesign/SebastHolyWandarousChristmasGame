extends Node2D

onready var name_generator = preload("res://scenes/hud/names.gd").new()
onready var hud = $ParallaxBackground/ParallaxLayer/hud

var kids

func _ready():
	randomize()
	
	kids = get_tree().get_nodes_in_group("dumb_kids")
	
	var names = name_generator.get_random_names(kids.size())
	
	for i in range(kids.size()):
		var name = names[i]
		var kid = kids[i]
		kid.set_name(name)
		kid.set_is_good_kid(bool(randi() % 2))
		hud.add_kid(kid)
		
func update_kid_display():
	hud.remove_all_dumb_kids()
	for i in range(kids.size()):
		var kid = kids[i]
		hud.add_kid(kid)
