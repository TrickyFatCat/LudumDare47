extends State

# warning-ignore:unused_argument
func unhandled_input(event: InputEvent) -> void:
	#* Here you can write logic which will be called in unhandled input
    #! DO NOT USE _unhandled_input() in inherited class
	return


# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
    owner._move_with_decelleration()
    if owner.velocity == 0:
        stateMachine.transition_to("Idle")


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	#* Here you can write logic which will be called on entering state
	return


func exit() -> void:
	#* Here you can write logic which will be called on exiting state
	return