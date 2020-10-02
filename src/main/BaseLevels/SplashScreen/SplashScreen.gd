extends BaseLevel

const SPLASH_DURATION : float = 0.5

export(String, FILE, "*.tscn") var next_level


func _on_SplashTimer_timeout() -> void:
	Events.emit_signal("load_level", {"target_level": next_level})


func ready() -> void:
	$SplashTimer.wait_time = SPLASH_DURATION
	Events.connect("transition_screen_opened", $SplashTimer, "start")
