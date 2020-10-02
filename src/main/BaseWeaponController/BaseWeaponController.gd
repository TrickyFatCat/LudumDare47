#* This is a base weapon controller which contains the most basic logic for all weapon controllers

extends Node2D
class_name WeaponController

var is_active : bool = true setget _set_is_active


func flip_weapon() -> void:
	var abs_rotation = fmod(abs(rotation_degrees), 360.0)
	
	if abs_rotation > 90 and abs_rotation < 270:
		scale.y = -1
	else:
		scale.y = 1


func switch_z_index() -> void:
	z_index = sign(fmod(global_rotation_degrees, 360.0))


func _set_is_active(value: bool) -> void:
	is_active = value
	set_process_unhandled_input(value)
	set_physics_process(value)
	set_process(value)