#* This is a script of a basic pickup frow which you can inherit all other pickups
# TODO make it moveable
# TODO add to player pickup magnet

extends PlayerTrigger
class_name Pickup


func _ready() -> void:
    connect("player_entered", self, "_activate_pickup_effect")


func _activate_pickup_effect() -> void:
    #* Write pickuplogic here
    pass