extends Node

var time = 120

signal time_up

func _ready():
	update_gift_count(0)

func _process(delta):
	time -= delta
	if time <= 0:
		emit_signal("time_up")
		set_process(false)
		time = 0

	$elements/timer.text = 'Time remaining: ' + str(round(time))

func update_gift_count(n):
	$elements/gift_counter.text = 'Gifts collected: ' + str(n)