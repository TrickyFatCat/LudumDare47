#* Simple pause menu logic
# TODO add restart logic

extends Menu

signal restart_pressed
signal resume_pressed
signal help_pressed
signal exit_pressed

const MAIN_MENU_PATH : String = "res://levels/Menus/MainMenu.tscn"

onready var menuConfirm := $MenuConfirm


func _ready() -> void:
	$Menu/MenuBody/Buttons/ButtonResume.connect("button_up", self, "_on_resume_up")
	$Menu/MenuBody/Buttons/ButtonHelp.connect("button_up", self, "_on_help_up")
	$Menu/MenuBody/Buttons/ButtonExit.connect("button_up", self, "_on_exit_up")
	_set_menu_buttons($Menu/MenuBody/Buttons)
	menuConfirm.connect("yes_pressed", self, "_confirm_action")
	menuConfirm.connect("no_pressed", self, "_decline_action")


func _on_resume_up() -> void:
	self.is_active = false
	emit_signal("resume_pressed")
	Events.emit_signal("menu_pause_closed")
	Utility.unpause_game()
	pass


func _on_help_up() ->  void:
	emit_signal("help_pressed")
	pass


func _on_exit_up() -> void:
	_switch_menu_visibility(false)
	menuConfirm.open_menu()
	action_to_confirm = Actions.LEVEL_EXIT
	emit_signal("exit_pressed")
	pass
	

func _confirm_action() -> void:
	match action_to_confirm:
		Actions.LEVEL_RESTART:
			Events.emit_signal("restart_level")
			pass
		Actions.LEVEL_EXIT:
			Events.emit_signal("level_exit")
			pass
	pass


func _decline_action() -> void:
	_switch_menu_visibility(true)
	pass


func _switch_menu_visibility(is_visible: bool) -> void:
	$Menu.visible = is_visible
	_set_buttons_active(is_visible)

	if is_visible:
		_focus_first_button()
	else:
		_release_focus()