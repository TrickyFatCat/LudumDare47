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
	calculate_velocity_x(delta)
	calculate_velocity_y(delta)
	# _calculate_velocity(delta, move_direction)
	_apply_movement()


func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func _calculate_move_direction() -> void:
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction = move_direction.normalized()


func calculate_velocity_x(delta : float) -> void:
	if move_direction.x != 0 and abs(velocity.x) <= velocity_max:
		velocity.x += acceleration * move_direction.x * delta
		velocity.x = clamp(velocity.x, -velocity_max * abs(move_direction.x), velocity_max * abs(move_direction.x))
	elif velocity.x != 0 or abs(velocity.y) > velocity_max:
		var friction_direction = -sign(velocity.x)
		velocity.x += friction * friction_direction * delta
		
		if friction_direction < 0:
			velocity.x = max(velocity.x, 0)
		elif friction_direction > 0:
			velocity.x = min(velocity.x, 0)


func calculate_velocity_y(delta : float) -> void:
	if move_direction.y != 0 and abs(velocity.y) <= velocity_max:
		velocity.y += acceleration * move_direction.y * delta
		velocity.y = clamp(velocity.y, -velocity_max * abs(move_direction.y), velocity_max * abs(move_direction.y))
	elif velocity.y != 0 or abs(velocity.y) > velocity_max:
		var friction_direction = -sign(velocity.y)
		velocity.y += friction * friction_direction * delta
		
		if friction_direction < 0:
			velocity.y = max(velocity.y, 0)
		elif friction_direction > 0:
			velocity.y = min(velocity.y, 0)