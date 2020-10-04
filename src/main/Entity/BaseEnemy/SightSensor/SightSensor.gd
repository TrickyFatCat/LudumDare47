extends Node2D
class_name SightSensor

signal player_detected
signal player_lost

export(float) var searching_radius := 48
export(float) var searching_fov := 360.0
export(bool) var is_debug_enabled = true

var _player_detected : bool = false
var _fov_tolerance : float = 0


func _ready() -> void:
	calculate_fov_tolerance()
	
	if GameManager.player == null:
		push_error("There is no player on the scene")


func _process(_delta) -> void:
	if GameManager.player != null:
		_process_player_detection()


func calculate_fov_tolerance() -> void:
	_fov_tolerance = deg2rad(searching_fov / 2)


func _process_player_detection() -> void:
	if _is_player_detected() and !_player_detected:
		_player_detected = !_player_detected
		emit_signal("player_detected")
	elif !_is_player_detected() and _player_detected:
		_player_detected = !_player_detected
		emit_signal("player_lost")


func _is_player_detected() -> bool:
	return _is_player_in_fov() and _is_player_in_los() and _is_player_in_searching_radius()


func _is_player_in_fov() -> bool:
	var facing_direction = Utility.get_facing_direction(self)
	var direction_to_player = Utility.get_direction_to_player(self)
	
	if abs(direction_to_player.angle_to(facing_direction)) < _fov_tolerance:
		return true
	
	return false


func _is_player_in_los() -> bool:
	var space = get_world_2d().direct_space_state
	var los_obstacle = space.intersect_ray(global_position, Utility.get_player_position(), [self], 3)
	
	if !los_obstacle:
		return false
	
	if los_obstacle.collider == GameManager.player:
		return true
	
	return false


func _is_player_in_searching_radius() -> bool:
	var distance_to_player = Utility.get_distance_to_player(self)
	
	if distance_to_player <= searching_radius:
		return true
	
	return false