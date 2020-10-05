extends Node

signal wave_started
signal wave_finished
signal wave_cleared

const ENEMY_SCENES : Array = [
	preload("res://content/Enemies/EnemyKamikaze.tscn"),
	preload("res://content/Enemies/Imp.tscn"),
	preload("res://content/Enemies/ZombieShotgunner.tscn"),
	preload("res://content/Enemies/Demon.tscn")
]

export(float) var spawn_pause := 1
export(int) var spawn_number := 1
export(Array, int) var enemy_count = [
	0,
	0,
	0,
	0
]
export(NodePath) var trigger_node

var enemy_data : Array = [
	[0, 0],
	[1, 0],
	[2, 0],
	[3, 0]
]
var spawn_points : Array
var enemy_counter : int = 0
var is_finished : bool = false

onready var timer : Timer = $Timer


func _ready() -> void:
	timer.wait_time = spawn_pause
	timer.one_shot = true
	timer.connect("timeout", self, "start_spawn")

	for i in range(enemy_data.size()):
		var count = enemy_count.pop_front()
		
		if count > 0:
			enemy_data[i][1] = count
	
	for i in range(enemy_data.size()):
		var data = enemy_data.pop_front()

		if data[1] > 0:
			enemy_data.append(data)

	for child in get_children():
		if child is SpawnPoint:
			spawn_points.append(child)

	
	yield(GameManager.current_level, "ready")
	if trigger_node:
		var node = get_node(trigger_node)
		if node is PlayerTrigger:
			node.connect("trigger_activated", self, "start_spawn", [], CONNECT_ONESHOT)
		if node is WallButton:
			node.connect("switched_on", self, "start_spawn", [], CONNECT_ONESHOT)


func start_spawn() -> void:
	if enemy_data.empty():
		return
	
	if not is_finished:
		emit_signal("wave_started")

	var count_sum = 0
	for data in enemy_data:
		count_sum += data[1]

	if count_sum < spawn_number:
		spawn_number -= spawn_number - count_sum
	
	for i in range(spawn_number):
		var data_index = randi() % enemy_data.size() if enemy_data.size() > 1 else 0
		var enemy_id = -1
		enemy_id = enemy_data[data_index][0]

		var spawn_point = null

		while true:
			spawn_point = spawn_points[randi() % spawn_points.size()]

			if not spawn_point.visible:
				break
		
		var enemy_instance = ENEMY_SCENES[enemy_id].instance()
		GameManager.current_level.enemy_parent.add_child(enemy_instance)
		enemy_instance.global_position = spawn_point.global_position
		enemy_instance.connect("spawn", spawn_point, "hide", [], CONNECT_ONESHOT)
		enemy_instance.connect("death", self, "_decrease_enemy_count", [], CONNECT_ONESHOT)
		enemy_counter += 1
		spawn_point.show()
		enemy_data[data_index][1] -= 1

		if enemy_data[data_index][1] <= 0:
			enemy_data.remove(data_index)
	
	if enemy_data.empty():
		timer.stop()
		is_finished = true
		emit_signal("wave_finished")

	timer.start()
		

func _decrease_enemy_count() -> void:
	enemy_counter -= 1

	if enemy_counter <= 0 and is_finished:
		emit_signal("wave_cleared")
