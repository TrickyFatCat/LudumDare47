#* This is a base sub move state for all entities
#* Inheret all submove states from this class

extends State
class_name EntitySubMove

onready var state_move : EntityMove = get_parent()


func unhandled_input(event: InputEvent) -> void:
	#* Here you can write logic which will be called in unhandled input
	#! DO NOT USE _unhandled_input() in inherited class
	pass


func physics_process(delta: float) -> void:
	#* Here you can write logic which will be called in _physics_process()
	#! DO NOT USE _physics_process() in inherited class
	pass


func enter(msg: Dictionary = {}) -> void:
	#* Here you can write logic which will be called on entering state
	pass


func exit() -> void:
	#* Here you can write logic which will be called on exiting state
	pass
