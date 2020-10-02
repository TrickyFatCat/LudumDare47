extends State
class_name EnemyChaseState

# TODO Rework this state

var target = GameManager.player
var direction : Vector2 = Vector2.ZERO

onready var look : RayCast2D = owner.get_node("Look")


func _physics_process(delta: float) -> void:
	var motion = direction * 5.0
	owner.move_and_slide(motion)


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
				break

	pass
