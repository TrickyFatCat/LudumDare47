extends EntityMove

var dash_velocity : Vector2


func apply_parameters_on_ready() -> void:
	dash_velocity = Vector2(owner.dash_velocity, owner.dash_velocity)


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dash"):
		var dash_direction := velocity.normalized() if move_direction != Vector2.ZERO else Vector2.RIGHT
		velocity = dash_velocity * dash_direction
		stateMachine.transition_to("Move/Dash")
	pass


func physics_process(delta: float) -> void:
	_calculate_move_direction()
	_calculate_velocity(delta, move_direction)
	_apply_movement()


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _calculate_move_direction() -> void:
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction = move_direction.normalized()