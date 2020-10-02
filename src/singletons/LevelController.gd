extends Node

const MAIN_MENU_PATH : String = "res://levels/Menus/MainMenu.tscn"


func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)


func load_main_menu() -> void:
	get_tree().change_scene(MAIN_MENU_PATH)


func load_next_level() -> void:
	# TODO Add next lever load logic here
	pass