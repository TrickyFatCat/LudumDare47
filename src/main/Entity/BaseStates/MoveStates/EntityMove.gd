extends State
class_name EntityMove

var move_direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var velocity_max : float
var acceleration : float
var friction : float


func _ready() -> void:
	# TODO Add check if the owner is a kinematic body 2D
	# TODO Add check if the owner has these parameters
	velocity_max = owner.velocity_max
	acceleration = owner.acceleration
	friction = owner.friction
	apply_parameters_on_ready()


func apply_parameters_on_ready() -> void:
	# Write any additional logic here
	pass


func _calculate_velocity(delta: float, direction: Vector2) -> void:
	if direction != Vector2.ZERO and (abs(velocity.x) <= velocity_max or abs(velocity.y) <= velocity_max):
		velocity += Vector2(acceleration, acceleration) * direction * delta
		velocity.x = _clamp_velocity(velocity.x)
		velocity.y = _clamp_velocity(velocity.y)
	elif velocity != Vector2.ZERO or (abs(velocity.x) > velocity_max or abs(velocity.y) > velocity_max):
		var friction_direction := velocity.normalized() * -1
		velocity += friction * friction_direction * delta
		velocity.x = _limit_velocity(velocity.x, friction_direction.x)
		velocity.y = _limit_velocity(velocity.y, friction_direction.y)


func _clamp_velocity(velocity_axis: float) -> float:
	return clamp(velocity_axis, -velocity_max, velocity_max)

		
func _limit_velocity(velocity_axis: float, direction_axis: float) -> float:
	if direction_axis < 0:
		velocity_axis = max(velocity_axis, 0)
	elif direction_axis > 0:
		velocity_axis = min(velocity_axis, 0)

	return velocity_axis


func _apply_movement() -> void:
	velocity = owner.move_and_slide(velocity) 