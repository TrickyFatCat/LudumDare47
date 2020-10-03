extends Node2D

onready var door := $Door
onready var button := $WallButton


func _ready() -> void:
	button.connect("switched_on", door, "set_is_locked", [false])
	button.connect("switched_off", door, "set_is_locked", [true])