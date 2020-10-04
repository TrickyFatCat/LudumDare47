extends State
class_name EnemyChaseState

# TODO Rework this state

var target = GameManager.player
var target_position : Vector2
var direction : Vector2 = Vector2.ZERO

var path : PoolVector2Array


onready var look : RayCast2D = owner.get_node("Look")
onready var navigation : Navigation2D = GameManager.current_level.get_node("Navmesh")


func physics_process(delta: float) -> void:
	if path.size() > 0:
		var distance_to_target = owner.position.distance_to(path[0])
		if distance_to_target > 64:
			var dir = (path[0] - owner.position).normalized()
			var velocity_move = dir.normalized() * 60
			owner.move_and_slide(velocity_move)
		else:
			path.remove(0)
	else:
		stateMachine.transition_to("Attack")


func enter(msg: Dictionary = {}) -> void:
	chase_target()
	return


func exit() -> void:
	return
	

func chase_target() -> void:
	path = navigation.get_simple_path(owner.position, Utility.get_player_position(), false)
	pass
