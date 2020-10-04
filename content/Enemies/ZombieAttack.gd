extends EnemyAttack

# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	owner.aim_to(GameManager.player.position)
	return


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	owner.sprite.play("idle")
	owner.aim_to(GameManager.player.position)
	owner.shoot()
	return


func exit() -> void:
	#* Here you can write logic which will be called on exiting state
	return
