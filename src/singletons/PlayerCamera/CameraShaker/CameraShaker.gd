extends Node

const TRANS := Tween.TRANS_SINE
const EASE := Tween.EASE_IN_OUT

var amplitude : int = 0
var priority : int = 0

onready var camera : Camera2D = get_parent()
onready var frequencyTimer : Timer = $FrequencyTimer
onready var durationTimer : Timer = $DurationTimer
onready var shakeTween : Tween = $ShakeTween


func _on_FrequencyTimer_timeout() -> void:
	_new_shake()
 

func _on_DurationTimer_timeout() -> void:
	_reset()
	frequencyTimer.stop()


func start(
	duration: float = 0.2,
	frequency: float = 15.0,
	shake_amplitude: int = 16,
	shake_priority: int = 0
	) -> void:
	if shake_priority >= self.priority:
		amplitude = shake_amplitude
		durationTimer.wait_time = duration
		frequencyTimer.wait_time = 1 / frequency
		durationTimer.start()
		frequencyTimer.start()
		_new_shake()


func _new_shake() -> void:
	var rand = Vector2.ZERO
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
# warning-ignore:return_value_discarded
	shakeTween.interpolate_property(
		camera,
		"offset",
		camera.offset,
		rand,
		frequencyTimer.wait_time,
		TRANS,
		EASE
	)
# warning-ignore:return_value_discarded
	shakeTween.start()


func _reset() -> void:
# warning-ignore:return_value_discarded
	shakeTween.interpolate_property(
		camera, "offset",
		camera.offset,
		Vector2.ZERO,
		frequencyTimer.wait_time,
		TRANS,
		EASE
	)
# warning-ignore:return_value_discarded
	shakeTween.start()
	priority = 0
