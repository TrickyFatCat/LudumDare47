extends Node2D
class_name ScentSpawner

const SCENT_SCENE := preload("res://src/Player/Scent/Scent.tscn")
const SPAWN_TIME : float = 0.1

var scent_trail : Array = []
var is_active : bool = true setget _set_is_active


func _ready() -> void:
	$Timer.wait_time = SPAWN_TIME
	$Timer.connect("timeout", self, "_add_scent")


func _set_is_active(value: bool) -> void:
	is_active = value

	if value:
		$Timer.start()
	else:
		$Timer.stop()


func _add_scent() -> void:
	if not is_active:
		return
		
	var scent = SCENT_SCENE.instance()
	scent.scent_spawner = self
	scent.position = position

	GameManager.current_level.add_child(scent)
	scent_trail.push_front(scent)
