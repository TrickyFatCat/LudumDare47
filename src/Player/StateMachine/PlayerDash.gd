#* Basic player dash logic
# TODO add cooldown timer or charge system for the dash

extends EntitySubMove


func unhandled_input(event: InputEvent) -> void:
	state_move.unhandled_input(event)
	pass


func physics_process(delta: float) -> void:
	state_move._calculate_velocity(delta, Vector2.ZERO)
	state_move._apply_movement()
	
	if abs(state_move.velocity.x) <= state_move.velocity_max and abs(state_move.velocity.y) <= state_move.velocity_max:
		stateMachine.transition_to("Move/Idle")


func enter(msg: Dictionary = {}) -> void:
	owner.deactivate_damage_detection()
	state_move.enter()


func exit() -> void:
	owner.activate_damage_detection()
	state_move.exit()
