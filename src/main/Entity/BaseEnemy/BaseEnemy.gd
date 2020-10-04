#* This is the base enemy class, it contains a basic logic for any enemy in the game
#* If you need a specific logic for the enemy, consider inherit from this class

extends Entity
class_name Enemy

export(float) var aggro_distance := 256.0
export(float) var attack_distance := 64.0
export(float) var wandering_distance := 32
export(int)  var shot_number_max := 3
export(float) var attack_pause : = 4.0
export(String, FILE, "*.tscn") var scene_to_spawn : String
export(int) var number_of_scenes := 1

var player_detected : bool = false

onready var lineOfSight : RayCast2D = $LineOfSight


func ready() -> void:
	connect("death", self, "on_death")
	Events.connect("player_dead", stateMachine, "transition_to", ["Move/Idle"])
	# TODO add ready logic for the base enemy
	pass



func _process(delta: float) -> void:
	if player_detected:
		return

	if global_position.distance_to(GameManager.player.global_position) <= aggro_distance:
		lineOfSight.cast_to = GameManager.player.get_node("CollisionShape2D").global_position - self.global_position
		lineOfSight.force_raycast_update()

		if lineOfSight.is_colliding() and lineOfSight.get_collider() is Player:
			if not player_detected:
				player_detected = true
				_on_player_detected()


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
	stateMachine.transition_to("Move/Chase")
	pass


func _on_player_lost() -> void:
	print_debug("player_lost")
	pass


func shoot() -> void:
	weaponController.weapon.process_shoot()


func aim_to(target: Vector2) -> void:
	weaponController.look_at(target)
