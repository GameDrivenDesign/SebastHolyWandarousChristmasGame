extends Node

var time = 120

signal time_up

onready var timer = $Control/MarginContainer/elements/timer
onready var gift_counter = $Control/MarginContainer/elements/gift_counter

onready var good_children = $Control/MarginContainer/elements/good_children
onready var bad_children = $Control/MarginContainer/elements/bad_children

func _ready():
	update_gift_count(0)

	# Delete all example children
	remove_all_dumb_kids()

func _process(delta):
	time -= delta
	if time <= 0:
		emit_signal("time_up")
		set_process(false)
		time = 0

	timer.text = 'Time remaining: ' + str(round(time))

func update_gift_count(n):
	gift_counter.text = 'Gifts collected: ' + str(n)

func add_kid(kid):
	#kid.connect("is_done", self, "kid_done")
	var label = Label.new()
	label.text = kid.get_name()
	label.add_font_override("font", preload("res://fonts/font20.tres"))
	
	#label.add_color_override("font_color_shadow", Color(0.0, 0.0, 0.0))
	
	if !kid.is_good_kid and !kid.alive:
		label.add_color_override("font_color", Color(0.5, 0.5, 0.5))
		label.add_color_override("font_color_shadow", Color(0.5, 0.5, 0.5))
	elif kid.got_gift:
		label.add_color_override("font_color", Color(0.0, 0.5, 0.0))
	elif !kid.alive:
		label.add_color_override("font_color", Color(0.8, 0.0, 0.0))
	else:
		label.add_color_override("font_color_shadow", Color(0.0, 0.0, 0.0))
	label.size_flags_horizontal = label.SIZE_EXPAND_FILL

	if kid.is_good_kid:
		good_children.add_child(label)
	else:
		bad_children.add_child(label)

#func kid_done(name, is_good_kid, got_present):
#	print("HUD: Kid with name " + name + " is done: good:" + str(is_good_kid) + ", present: " + str(got_present))

func _on_credits_button_pressed():
	$credits.popup_centered()

func remove_all_dumb_kids():
	for child in good_children.get_children():
		child.queue_free()
	for child in bad_children.get_children():
		child.queue_free()