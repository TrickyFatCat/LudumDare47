extends State
class_name EnemyAttack

export(int) var shot_number_max := 3
export(float) var attack_pause : = 4.0

var shot_number : int = 0

onready var timer : Timer = $Timer


func _ready() -> void:
	yield(GameManager.current_level, "ready")
	owner.weaponController.weapon.connect("shoot", self, "_on_enemy_shoot")
	timer.wait_time = attack_pause
	timer.one_shot = true


# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	if timer.is_stopped():
		owner.aim_to(GameManager.player.position)
		owner.shoot()
	else:
		stateMachine.transition_to("Move/Wander")
	#* Here you can write logic which will be called in _physics_process()
	#! DO NOT USE _physics_process() in inherited class
	return


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	owner.sprite.play("idle")
	owner.aim_to(GameManager.player.position)
	return


func exit() -> void:
	#* Here you can write logic which will be called on exiting state
	return


func _on_enemy_shoot() -> void:
	shot_number += 1

	if shot_number >= shot_number_max:
		shot_number = 0
		timer.start()
	pass
