#* Player character main script

extends Entity
class_name Player

export(float) var dash_velocity := 700


func _init() -> void:
	GameManager.player = self


func switch_logic(value: bool) -> void:
	$CameraRig.set_physics_process(value)


func ready() -> void:
	# TODO add ready logic for the player character
	connect("death", self, "on_death")
	Events.connect("player_heal", self, "_process_heal")
	Events.connect("restore_ammo", self, "_restore_ammo")
	Events.connect("level_finished", self, "_transition_to_inacitve")
	pass


func get_ammo_current(ammo_id: int) -> int:
	return $WeaponController.get_ammo_current(ammo_id)


func get_ammo_max(ammo_id: int) -> int:
	return $WeaponController.get_ammo_max(ammo_id)


func _on_spawn() -> void:
	# TODO add spawn logic on player
	Events.emit_signal("player_spawned")
	pass


func _on_get_damage(damage: int) -> void:
	_decrease_hitpoints(damage)
	# AudioPlayer.play("res://sounds/sfx_player_wound.wav")
	# TODO add logic on get damage
	pass


func _on_hitpoints_decreased() -> void:
	Events.emit_signal("update_player_hitpoints", hitPoints.value)
	Events.emit_signal("shake_camera")
	sprite.set_flash_color(Color.red)
	sprite.start_flash(true)
	pass


func _on_zero_hitpoints() -> void:
	# TODO add logic on zero hitpoints
	Events.emit_signal("player_dead")
	stateMachine.transition_to("Death")
	pass

func on_death() -> void:
	$Shadow.visible = false
	weaponController.visible = false
	sprite.connect("animation_finished", self, "_death_ended", [], CONNECT_ONESHOT)
	sprite.offset.y = -20
	sprite.play("death")

func _death_ended() -> void:
	self.is_active = false
	Events.emit_signal("show_gameover")
	pass


func get_scent_trail() -> Array:
	return $ScentSpawner.scent_trail


func _process_heal(heal: int) -> void:
	AudioPlayer.play("res://sounds/sfx_pickup_medkit.wav")
	_increase_hitpoints(heal)
	sprite.set_flash_color(Color.green)
	sprite.start_flash(true)
	Events.emit_signal("update_player_hitpoints", hitPoints.value)


func _restore_ammo(ammo_id: int, number: int) -> void:
	AudioPlayer.play("res://sounds/sfx_pickup_ammo.wav")
	weaponController.increase_ammo_current(ammo_id, number)
	sprite.set_flash_color(Color.orange)
	sprite.start_flash(true)


func _transition_to_inacitve() -> void:
	stateMachine.set_process_unhandled_input(false)
	switch_logic(false)
	weaponController.is_active = false