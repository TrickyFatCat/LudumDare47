extends PlayerTrigger


func _ready() -> void:
	connect("trigger_activated", self, "_on_finish_level")


func _on_finish_level() -> void:
	Events.emit_signal("level_finished")
	pass