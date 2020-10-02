#* Player character main script

extends Entity
class_name Player

export(float) var dash_velocity := 700


func _init() -> void:
	GameManager.player = self


func switch_logic(value: bool) -> void:
	$CameraRig.set_physics_process(value)
	$ScentSpawner.is_active = value


func ready() -> void:
	# TODO add ready logic for the player character
	pass


func _on_spawn() -> void:
	# TODO add spawn logic on player
	Events.emit_signal("player_spawned")
	pass


func _on_get_damage(damage: int) -> void:
	_decrease_hitpoints(damage)
	# TODO add logic on get damage
	pass


func _on_hitpoints_decreased() -> void:
	Events.emit_signal("player_took_damage", hitPoints.value)
	Events.emit_signal("shake_camera")
	sprite.start_flash(true)
	pass


func _on_zero_hitpoints() -> void:
	# TODO add logic on zero hitpoints
	Events.emit_signal("player_dead")
	self.is_active = false
	stateMachine.transition_to("Death")
	pass


func get_scent_trail() -> Array:
	return $ScentSpawner.scent_trail