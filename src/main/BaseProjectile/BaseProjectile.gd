#* This is a base projectile class which contains the basic logic for all projectiles

extends KinematicBody2D
class_name Projectile

enum MotionType {
	LINEAR,
	ACCELERATED,
	DECELERATED
}

enum BounceType {
	NORMAL,
	ACCELERATED,
	DECELERATED
}

var move_direction : Vector2

#* Damage parameters
var damage : int

#* Basic movement parameters
var motion_type : int
var velocity : float
var velocity_max : float
var acceleration : float
var friction : float

#* Bounce parameterts
var is_bounceable : bool
var bounce_type : int
var bounce_velocity_factor : float
var bounce_direction_noise : float

#* Spawned scene parameters
var spawned_scene_path : String

onready var sprite : Sprite = $Sprite


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(_calculate_motion(delta, move_direction))
	
	if is_bounceable and collision:
		_process_bounce(collision)


func apply_parameters(parameters: ProjectileParameters) -> void:
	#* General parameters
	sprite.texture = parameters.sprite

	#* Damage parameters
	damage = parameters.damage

	#* Basic movement parameters
	motion_type = parameters.motion_type

	if motion_type == MotionType.DECELERATED:
		$LifeSpanTimer.stop()

	velocity = parameters.velocity_initial
	velocity_max = parameters.velocity_max
	acceleration = parameters.acceleration
	friction = parameters.friction
	
	#* Bounce parameters
	is_bounceable = parameters.is_bounceable
	bounce_type = parameters.bounce_type
	bounce_velocity_factor = parameters.bounce_velocity_factor
	bounce_direction_noise = parameters.bounce_direction_noise

	#* Spawned scene parameters
	spawned_scene_path = parameters.spawned_scene_path


func destroy(is_spawning: bool = true) -> void:
	# TODO add destroy logic here
	# TODO add spawn logic on destroy here
	queue_free()
	pass


func _process_bounce(collision: KinematicCollision2D) -> void:
	move_direction = move_direction.bounce(collision.normal)

	if bounce_direction_noise > 0:
		var direction_noise = deg2rad(rand_range(-bounce_direction_noise, bounce_direction_noise))
		move_direction = move_direction.rotated(direction_noise)

	rotation = move_direction.angle()

	match bounce_type:
		BounceType.NORMAL:
			# Nothing to do here
			pass

		BounceType.ACCELERATED:
			velocity += velocity * bounce_velocity_factor
			pass

		BounceType.DECELERATED:
			velocity -= velocity * bounce_velocity_factor
			pass


func _calculate_motion(delta: float, direction: Vector2) -> Vector2:
	match motion_type:
		MotionType.LINEAR:
			# Nothing to do here
			pass

		MotionType.ACCELERATED:
			if velocity < velocity_max:
				velocity += acceleration * delta
				velocity = min(velocity, velocity_max)
			pass

		MotionType.DECELERATED:
			if velocity > 0:
				velocity -= friction * delta
				velocity = max(velocity, 0)
			else:
				destroy()
			pass
	
	return velocity * direction
