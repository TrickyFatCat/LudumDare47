extends AudioStreamPlayer

const MIN_VOLUME : float = -80.0

export(float) var target_volume := 0


func _init() -> void:
	volume_db = 0


func _ready() -> void:
	Events.connect("transition_started", self, "set_process", [true])
	Events.connect("transition_stopped", self, "set_process", [false])
	play()
	pass


func _process(delta: float) -> void:
	volume_db = lerp(MIN_VOLUME, target_volume, TransitionScreen.tween_progress)
