extends Pickup

export(int, "Bullet", "Shell", "Energy", "Explosives") var ammo_type
export(int) var number := 1


func _activate_pickup_effect() -> void:
	if GameManager.player.get_ammo_current(ammo_type) < GameManager.player.get_ammo_max(ammo_type):
		Events.emit_signal("restore_ammo", ammo_type, number)
		queue_free()
	pass
