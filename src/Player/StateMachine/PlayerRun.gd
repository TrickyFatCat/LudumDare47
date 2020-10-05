#* Player run state

extends EntitySubMove

func _ready() -> void:
	yield(owner, "ready")
	owner.sprite.connect("animation_finished", self, "_play_sound")


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
	owner.sprite.play("run")


func exit() -> void:
	state_move.exit()


func _play_sound() -> void:
	if owner.sprite.animation == "run":
		AudioPlayer.play("res://sounds/sfx_player_step.wav")
