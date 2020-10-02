extends Area2D
class_name PlayerTrigger

signal player_entered()
signal player_exited()
signal trigger_activated()
signal trigger_deactivated()

export(bool) var is_oneshot := false
export(bool) var is_interactable := false

var is_player_inside : bool = false
var is_activated : bool = false


func _unhandled_input(event: InputEvent) -> void:
    if is_interactable and is_player_inside and event.is_action_pressed("interact"):
        if not is_activated:
            _activate_trigger()
        else:
            _deactivate_trigger() 
        


func _on_body_entered(body: KinematicBody2D) -> void:
    is_player_inside = true
    emit_signal("player_entered")
    
    if not is_interactable:
        _activate_trigger()


func _on_body_exited(body: KinematicBody2D) -> void:
    is_player_inside = false
    emit_signal("player_exited")
    
    if not is_interactable:
        _deactivate_trigger()


func _activate_trigger() -> void:
    if not is_activated:
        is_activated = true
        emit_signal("trigger_activated")
    

func _deactivate_trigger() -> void:
    if is_activated and not is_oneshot:
        is_activated = false
        emit_signal("trigger_deactivated")