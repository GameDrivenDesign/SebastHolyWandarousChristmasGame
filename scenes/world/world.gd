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
		kid.connect("is_done", self, "kid_done")
	
	var trees = $trees
	
	var map_size = Vector2(120*50, 100*50)
	var quadrant_size = 6 * 50
	
	for xi in range(map_size.x / quadrant_size):
		for yi in range(map_size.y / quadrant_size):
			if randi() % 100 > 50:
				var tree = preload("res://scenes/tree/tree.tscn").instance()
				tree.global_position = Vector2(
					xi * quadrant_size + rand_range(0, quadrant_size / 2),
					yi * quadrant_size + rand_range(0, quadrant_size / 2)
				)
				trees.add_child(tree)

func kid_done(name, is_good_kid, got_present):
	print("World: Kid with name " + name + " is done: good:" + str(is_good_kid) + ", present: " + str(got_present))
	update_kid_display()

func update_kid_display():
	hud.remove_all_dumb_kids()
	for i in range(kids.size()):
		var kid = kids[i]
		hud.add_kid(kid)
