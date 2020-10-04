extends EntitySubMove

# TODO Rework this state

export(float) var wandering_

var path : PoolVector2Array
var target_point : Vector2

onready var navigation : Navigation2D = GameManager.current_level.get_node("Navmesh")

func physics_process(delta: float) -> void:
	if owner.global_position.distance_to(target_point) <= 4:
		if Utility.get_distance_to_player(owner) <= owner.attack_distance:
			stateMachine.transition_to("Attack")
		else:
			stateMachine.transition_to("Move/Chase")
		return

	
	if path.size() > 0:
		var distance_to_target = owner.global_position.distance_to(path[0])
		if distance_to_target > 1:
			state_move.move_direction = (path[0] - owner.position).normalized()
			state_move._flip_sprite(state_move.move_direction)
			state_move.velocity = state_move.move_direction * state_move.velocity_max * delta
			state_move._apply_movement()
		else:
			path.remove(0)
	else:
		if Utility.get_distance_to_player(owner) <= owner.attack_distance:
			stateMachine.transition_to("Attack")
		else:
			stateMachine.transition_to("Move/Chase")


func enter(msg: Dictionary = {}) -> void:
	chase_target()
	owner.sprite.play("run")
	return


func exit() -> void:
	return
	

func chase_target() -> void:
	target_point.x = owner.global_position.x + rand_range(-owner.wandering_distance, owner.wandering_distance)
	target_point.y = owner.global_position.y + rand_range(-owner.wandering_distance, owner.wandering_distance)
	path = navigation.get_simple_path(owner.global_position, navigation.get_closest_point(target_point), false)
	owner.get_node("Line2D").points = path
	owner.get_node("Line2D").set_as_toplevel(true)
	pass
