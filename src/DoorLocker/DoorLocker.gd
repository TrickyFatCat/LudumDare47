extends Node

export(NodePath) var spawner_node
export(Array, NodePath) var door_nodes


func _ready() -> void:
	var spawner = get_node(spawner_node)

	for door_node in door_nodes:
		var door = get_node(door_node)
		spawner.connect("wave_started", door, "set_is_locked", [true], CONNECT_ONESHOT)
		spawner.connect("wave_cleared", door, "set_is_locked", [false], CONNECT_ONESHOT)