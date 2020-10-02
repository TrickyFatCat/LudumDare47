#* This script contains a basic logic of game levels.

extends Node
class_name BaseLevel

const LOAD_DEALAY_TIME : float = 0.5
const YSORT_NODE_NAME : String = "Objects"

var objects_node : YSort
var projectiles_parent : Node


func _init() -> void:
	GameManager.current_level = self
	init()


func _ready() -> void:
	objects_node = get_node(YSORT_NODE_NAME) if has_node(YSORT_NODE_NAME) else null
	
	if objects_node:
		projectiles_parent = objects_node.get_node("Projectiles")

	ready()
	yield(get_tree().create_timer(LOAD_DEALAY_TIME), "timeout")
	Events.emit_signal("level_loaded")


func init() -> void:
	pass


func ready() -> void:
	pass
