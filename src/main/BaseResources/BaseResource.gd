extends Node
class_name BaseResource

signal value_decreased()
signal value_increased()
signal value_max_increased()
signal value_max_decreased()
signal value_zero()

const VALUE_MIN : int = 0

export(int) var value_start := 0 setget set_value_start
export(int) var value_max := 0 setget set_value_max

var value : int = 0


func _inint() -> void:
    value = value_max if value_start <= 0 else value_start


func decrease_value(amount: int) -> void:
    value -= amount
    value = int(max(value, VALUE_MIN))

    if value > 0:
        emit_signal("value_decreased")
    else:
        emit_signal("value_zero")


func decrease_max_value(amount: int) -> void:
    value_max -= amount
    value_max = int(max(value_max, VALUE_MIN))
    
    if value_max > 0:
        emit_signal("value_max_decreased")
    else:
        value = value_max
        emit_signal("value_zero")


func increase_value_limited(amount: int) -> void:
    value += amount
    value = int(min(value, value_max))
    emit_signal("value_increased")


func increase_value(amount: int) -> void:
    value += amount
    emit_signal("value_increased")


func increase_max_value(amount: int) -> void:
    value_max += amount
    emit_signal("value_max_increased")


func set_value_start(value: int) -> void:
    value_start = value

    if value_start > 0:
        value = value_start


func set_value_max(value: int) -> void:
    value_max = value
    
    if value_start <= 0:
        value = value_max