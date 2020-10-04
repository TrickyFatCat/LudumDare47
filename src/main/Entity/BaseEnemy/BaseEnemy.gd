#* This is the base enemy class, it contains a basic logic for any enemy in the game
#* If you need a specific logic for the enemy, consider inherit from this class

extends Entity
class_name Enemy

export(float) var attack_distance := 64.0
export(String, FILE, "*.tscn") var scene_to_spawn : String
export(int) var number_of_scenes := 1

onready var playerSensor := $PlayerSensor


func ready() -> void:
	$PlayerSensor.connect("player_detected", self, "_on_player_detected")
	$PlayerSensor.connect("player_lost", self, "_on_player_lost")
	connect("death", self, "on_death")
	# playerSensor.connect("player_detected", self, "_on_player_detected")
	# playerSensor.connect("player_lost", self, "_on_player_lost")
	# TODO add ready logic for the base enemy
	pass


func is_seeing_player() -> bool:
	return $PlayerSensor.is_player_detected


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
	stateMachine.transition_to("Death")
	pass


func on_death() -> void:
	if scene_to_spawn:
		var scene := load(scene_to_spawn)
		var scene_instance = scene.instance()
		GameManager.current_level.objects_node.add_child(scene_instance)
		scene_instance.global_position = global_position

	queue_free()
	pass


func _on_player_detected() -> void:
	print_debug("player_detected")
	pass


func _on_player_lost() -> void:
	print_debug("player_lost")
	pass


func shoot() -> void:
	weaponController.weapon.process_shoot()


func aim_to(target: Vector2) -> void:
	weaponController.look_at(target)