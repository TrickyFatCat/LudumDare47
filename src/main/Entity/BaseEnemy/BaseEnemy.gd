#* This is the base enemy class, it contains a basic logic for any enemy in the game
#* If you need a specific logic for the enemy, consider inherit from this class

extends Entity
class_name Enemy

var target


func ready() -> void:
	# TODO add ready logic for the base enemy
	pass


func _on_spawn() -> void:
	# TODO add logic on spawn end
	pass


func _on_get_damage(damage: int) -> void:
	_decrease_hitpoints(damage)
	# TODO add logic on get damage
	pass


func _on_hitpoints_decreased() -> void:
	sprite.start_flash(true)
	pass


func _on_zero_hitpoints() -> void:
	# TODO add logic on zero hitpoints
	# TODO rework this code
	# self.is_active = false
	queue_free()
	pass
