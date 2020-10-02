#* This is a basic data panel class. It contains basic functions for this class.
#* Inherit all data panels from this class.

extends Control
class_name DataPanel

export(bool) var is_active := true setget _set_is_active


func _set_is_active(value: bool) -> void:
    is_active = value
    visible = value