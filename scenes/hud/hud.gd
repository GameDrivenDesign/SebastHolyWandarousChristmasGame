extends Node

var time = 120
var gifts = 0

func _ready():
	pass

func _process(delta):
	time -= delta
	$elements/timer.text = 'Time remaining: ' + str(round(time))
	$elements/gift_counter.text = 'Gifts collected: ' + str(gifts)