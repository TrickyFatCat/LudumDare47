extends EntityDeath

const SCALE_FACTOR : float = 1.5
export(float) var death_duration : = 0.5

onready var tween : Tween = $Tween

func _ready() -> void:
	tween.connect("tween_all_completed", self, "exit")

func unhandled_input(event: InputEvent) -> void:
	#* Here you can write logic which will be called in unhandled input
	#! DO NOT USE _unhandled_input() in inherited class
	pass


func physics_process(delta: float) -> void:
	#* Here you can write logic which will be called in _physics_process()
	#! DO NOT USE _physics_process() in inherited class
	pass


func enter(msg: Dictionary = {}) -> void:
	owner.sprite.play("idle")
	tween.interpolate_property(
		owner.sprite,
		"scale",
		owner.sprite.scale,
		owner.sprite.scale * SCALE_FACTOR,
		death_duration,
		Tween.TRANS_EXPO,
		Tween.EASE_IN_OUT
	)
	tween.start()
	owner.sprite.start_flash(false)
	pass


func exit() -> void:
	print("exit")
	owner.emit_signal("death")
	pass
