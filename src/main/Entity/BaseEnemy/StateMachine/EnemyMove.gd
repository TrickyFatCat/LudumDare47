extends EntityMove

# TODO update this state if necessary

func apply_parameters_on_ready() -> void:
    # Called in _ready function of the main class
    pass


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	# _calculate_move_direction()
	_calculate_velocity(delta, move_direction)
	_apply_movement()


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return