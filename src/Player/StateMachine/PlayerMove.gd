extends EntityMove

export(float) var dash_cooldown := 2.0

var dash_velocity : Vector2
var timer : Timer

func apply_parameters_on_ready() -> void:
	dash_velocity = Vector2(owner.dash_velocity, owner.dash_velocity)
	timer = $Timer
	timer.wait_time = dash_cooldown
	timer.one_shot = true


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") and timer.is_stopped():
		var dash_direction := velocity.normalized() if move_direction != Vector2.ZERO else Vector2.RIGHT
		velocity = dash_velocity * dash_direction
		stateMachine.transition_to("Move/Dash")
		timer.start()
	pass


func physics_process(delta: float) -> void:
	_calculate_move_direction()
	_flip_sprite(move_direction)
	_calculate_velocity(delta, move_direction)
	_apply_movement()


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func _calculate_move_direction() -> void:
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction = move_direction.normalized()
