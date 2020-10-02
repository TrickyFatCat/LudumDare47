#* Player run state

extends EntitySubMove


func unhandled_input(event: InputEvent) -> void:
	state_move.unhandled_input(event)
	pass


func physics_process(delta: float) -> void:
	if state_move.move_direction == Vector2.ZERO:
		stateMachine.transition_to("Move/Idle")
		return

	state_move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	state_move.enter()


func exit() -> void:
	state_move.exit()
