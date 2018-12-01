extends Node

var time = 120

signal time_up

onready var timer = $Control/MarginContainer/elements/timer
onready var gift_counter = $Control/MarginContainer/elements/gift_counter

func _ready():
	update_gift_count(0)

func _process(delta):
	time -= delta
	if time <= 0:
		emit_signal("time_up")
		set_process(false)
		time = 0

	timer.text = 'Time remaining: ' + str(round(time))

func update_gift_count(n):
	gift_counter.text = 'Gifts collected: ' + str(n)

func kid_done(name, success):
	print("HUD: Kid with name " + name + " is done: " + str(success))