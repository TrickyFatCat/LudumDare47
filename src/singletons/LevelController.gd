extends Node

const MAIN_MENU_PATH : String = "res://levels/Menus/MainMenu.tscn"
const LEVELS : Array = [
	"res://levels/Levels/Level01.tscn",
	"res://levels/Levels/Level02.tscn",
	"res://levels/Levels/Level03.tscn"
]


func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)


func load_main_menu() -> void:
	get_tree().change_scene(MAIN_MENU_PATH)


func load_next_level() -> void:
	if GameManager.current_level.level_id > -1:
		var new_level_id = GameManager.current_level.level_id + 1
		
		if new_level_id >= LEVELS.size():
			load_main_menu()
			return

		get_tree().change_scene(LEVELS[new_level_id])
	pass
