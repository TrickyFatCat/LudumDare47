#* inheret new state classes for different entities frome this class

extends State
class_name EntitySpawn


func unhandled_input(event: InputEvent) -> void:
	#* Here you can write logic which will be called in unhandled input
	#! DO NOT USE _unhandled_input() in inherited class
	pass


func physics_process(delta: float) -> void:
	#* Here you can write logic which will be called in _physics_process()
	#! DO NOT USE _physics_process() in inherited class
	pass


func enter(msg: Dictionary = {}) -> void:
	owner.sprite.connect("animation_finished", self, "to_idle", [], CONNECT_ONESHOT)
	owner.sprite.play("spawn")
	owner.sprite.set_flash_color(Color.white)
	owner.sprite.start_flash(false)
	owner.damageDetector.call_deferred("_set_is_active", false)
	#* Here you can write logic which will be called on entering state
	pass


func exit() -> void:
	owner.emit_signal("spawn")
	pass


func to_idle() -> void:
	if owner.is_weapon_visible:
		owner.show_weapon()
	owner.sprite.play("idle")
	yield(get_tree().create_timer(1), "timeout")
	owner.damageDetector.call_deferred("_set_is_active", true)
	owner.sprite.stop_flash()
	stateMachine.transition_to("Move/Idle")