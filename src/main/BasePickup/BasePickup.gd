#* This is a script of a basic pickup frow which you can inherit all other pickups
# TODO make it moveable
# TODO add to player pickup magnet

extends PlayerTrigger
class_name Pickup


func _init() -> void:
    connect("trigger_activated", self, "_activate_pickup_effect")
    connect("trigger_activated", self, "queue_free")


func _activate_pickup_effect() -> void:
    #* Write pickuplogic here
    print_debug()
    pass