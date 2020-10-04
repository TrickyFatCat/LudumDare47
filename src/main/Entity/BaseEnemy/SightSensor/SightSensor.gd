extends Node2D
class_name SightSensor

signal player_detected
signal player_lost

export(float) var searching_radius := 512
export(float) var searching_fov := 360.0
export(bool) var is_debug_enabled = true

var is_player_detected : bool = false
var _fov_tolerance : float = 0


func _ready() -> void:
	
	if GameManager.player == null:
		push_error("There is no player on the scene")


func _process(_delta) -> void:
	_process_player_detection()



func _process_player_detection() -> void:
	if _is_player_detected() and !is_player_detected:
		is_player_detected = !is_player_detected
		emit_signal("player_detected")
	elif !_is_player_detected() and is_player_detected:
		is_player_detected = !is_player_detected
		emit_signal("player_lost")


func _is_player_detected() -> bool:
	return _is_player_in_los() and _is_player_in_searching_radius()


func _is_player_in_los() -> bool:
	var space = get_world_2d().direct_space_state
	var los_obstacle = space.intersect_ray(global_position, Utility.get_player_position(), [self], 5)
	
	if !los_obstacle:
		return false
	
	if los_obstacle.collider == GameManager.player:
		return true
	
	return false


func _is_player_in_searching_radius() -> bool:
	var distance_to_player = Utility.get_distance_to_player(owner)
	
	if distance_to_player <= searching_radius:
		return true
	
	return false