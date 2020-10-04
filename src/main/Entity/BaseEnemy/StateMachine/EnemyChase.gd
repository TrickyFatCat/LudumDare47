extends EntitySubMove
class_name EnemyChaseState

# TODO Rework this state

var path : PoolVector2Array

onready var navigation : Navigation2D = GameManager.current_level.get_node("Navmesh")

func physics_process(delta: float) -> void:
	if Utility.get_distance_to_player(owner) <= owner.attack_distance:
		stateMachine.transition_to("Attack")
		return

	
	if Utility.get_player_position().distance_to(path[(path.size() - 1)]) > owner.attack_distance:
		chase_target()
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
		stateMachine.transition_to("Attack")


func enter(msg: Dictionary = {}) -> void:
	chase_target()
	owner.sprite.play("run")
	return


func exit() -> void:
	return
	

func chase_target() -> void:
	path = navigation.get_simple_path(owner.global_position, GameManager.player.global_position, false)
	owner.get_node("Line2D").points = path
	owner.get_node("Line2D").set_as_toplevel(true)
	pass
