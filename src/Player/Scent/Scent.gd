extends Node2D

var scent_spawner : Node


func _ready() -> void:
	$Timer.connect("timeout", self, "_remove_scent")


func remove_scent() -> void:
	scent_spawner.scent_trail.erase(self)
	queue_free()
