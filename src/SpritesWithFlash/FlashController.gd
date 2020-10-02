extends Node

signal flash_finished()

const MIN_FLASH_ALPHA: float = 0.0
const MAX_FLASH_ALPHA: float = 1.0

export(float) var flash_duration_time := 0.35

var is_oneshot : bool = true

onready var material : ShaderMaterial = get_parent().material
onready var tween : Tween = $Tween


func _ready() -> void:
	tween.connect("tween_all_completed", self, "_restart_flash")


func start_flash(flash_once: bool = true) -> void:
    is_oneshot = flash_once
    _start_tween()


func stop_flash() -> void:
	is_oneshot = true


func _set_flash_alpha(value: float) -> void:
	value = clamp(value, MIN_FLASH_ALPHA, MAX_FLASH_ALPHA)
	material.set_shader_param("u_alpha", value)


func _start_tween() -> void:
	tween.interpolate_method(
		self,
		"_set_flash_alpha",
		MAX_FLASH_ALPHA,
		MIN_FLASH_ALPHA,
		flash_duration_time,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	tween.start()


func _restart_flash() -> void:
	if not is_oneshot:
		_start_tween()
	else:
		emit_signal("flash_finished")