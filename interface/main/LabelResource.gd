#* A simple script which change text of label to XXX/XXX format

extends Label

export(int) var zeros_number := 3

var value_current : int
var value_max : int
var zeros : String = ""


func _init() -> void:
    zeros = "%0" + String(zeros_number) + "d"


func update_value_current(value: int) -> void:
    value_current = value
    _update_text()


func update_value_max(value: int) -> void:
    value_max = value
    _update_text()


func update_all_values(current_value: int, max_vaule: int) -> void:
    value_current = current_value
    value_max = max_vaule
    _update_text()


func _update_text() -> void:
    text = String(zeros % value_current) + "/" + String(zeros % value_max)