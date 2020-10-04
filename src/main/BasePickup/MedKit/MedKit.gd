extends Pickup

export(int) var heal_power := 25

func _activate_pickup_effect() -> void:
	if GameManager.player.get_hitpoints_current() < GameManager.player.get_hitpoints_max():
		Events.emit_signal("player_heal", heal_power)
		queue_free()
	pass
