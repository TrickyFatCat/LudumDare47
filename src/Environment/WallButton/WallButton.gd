extends StaticBody2D
class_name WallButton

signal switched_on
signal switched_off

export(bool) var is_oneshot := false

onready var sprite := $AnimatedSprite


func _ready() -> void:
	$PlayerTrigger.connect("trigger_activated", self, "_on_activation")
	$PlayerTrigger.connect("trigger_deactivated", self, "_on_deactivation")


func _on_activation() -> void:
	emit_signal("switched_on")
	sprite.play("green")
	AudioPlayer.play("res://sounds/sfx_button.wav")

	if is_oneshot:
		$PlayerTrigger.set_process_unhandled_input(false)


func _on_deactivation() -> void:
	emit_signal("switched_off")
	sprite.play("red")
	AudioPlayer.play("res://sounds/sfx_button.wav")