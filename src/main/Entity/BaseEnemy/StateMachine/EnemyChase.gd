extends State
class_name EnemyChaseState

# TODO Rework this state

var target = GameManager.player
var target_position : Vector2
var direction : Vector2 = Vector2.ZERO

onready var look : RayCast2D = owner.get_node("Look")


func _physics_process(delta: float) -> void:
	var motion = direction * 20.0
	owner.move_and_slide(motion)

	print(owner.global_position.distance_to(target_position))

	if owner.position.distance_to(target_position) < 64:
		chase_target()


func enter(msg: Dictionary = {}) -> void:
	chase_target()
	return


func exit() -> void:
	return
	

func chase_target() -> void:
	look.cast_to  = target.position - owner.position
	look.force_raycast_update()

	if !look.is_colliding():
		direction = look.cast_to.normalized()
	else:
		for scent in target.get_scent_trail():
			look.cast_to = scent.position - owner.position
			look.force_raycast_update()
		
			if !look.is_colliding():
				direction = look.cast_to.normalized()
				target_position = scent.position
				break

	pass
