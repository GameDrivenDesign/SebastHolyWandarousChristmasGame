extends Node

var time = 12
var gifts = 0

signal time_up

func _ready():
	$elements/gift_counter.text = 'Gifts collected: ' + str(gifts)

func _process(delta):
	time -= delta
	if time <= 0:
		emit_signal("time_up")
		set_process(false)
		time = 0

	$elements/timer.text = 'Time remaining: ' + str(round(time))