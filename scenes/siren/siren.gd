extends Node

const white = Color(1.0, 1.0, 1.0)
const red = Color("ed6262")

onready var audio_length = $audio.stream.get_length()
onready var light = get_parent().get_node("Light2D")

var n_flashes = -1
var is_flashing = false

func _on_tween1_completed(a, b):
	$tween2.interpolate_property(light, "color", red, white, audio_length / 2, 
		Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$tween2.start()

func _on_tween2_completed(a, b):
	if n_flashes <= 0:
		$audio.stop()
		return
	n_flashes -= 1
	
	$tween1.interpolate_property(light, "color", white, red, audio_length / 2,
		Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$tween1.start()

func flash(n):
	n_flashes = n
	if not is_flashing:
		$audio.play()
		_on_tween2_completed(null, null)