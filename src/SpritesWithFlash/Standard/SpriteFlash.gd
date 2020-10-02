extends Sprite
class_name FlashingSprite

signal flash_finished

export(float) var flash_duration_time := 0.35

onready var flashController : Node = $FlashController


func _ready() -> void:
	flashController.flash_duration_time = flash_duration_time
	flashController.connect("flash_finished", self, "emit_flash_finished")

func start_flash(flash_once: bool) -> void:
	flashController.start_flash(flash_once)


func stop_flash() -> void:
	flashController.stop_flash()


func set_flash_color(new_colour: Color) -> void:
	material.set_shader_param("u_colour", new_colour)


func emit_flash_finished() -> void:
	emit_signal("flash_finished")