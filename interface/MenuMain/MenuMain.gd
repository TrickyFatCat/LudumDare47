#* This script contains logic of the main menu.

tool
extends Menu

export(String, FILE, "*.tscn") var starting_level

onready var menuConfirm := $MenuConfirm


func _ready() -> void:
	_set_menu_buttons($Menu/MenuBody/Buttons)
	_set_buttons_active(false)
	Events.connect("transition_screen_opened", self, "_activate_menu")
	menuConfirm.connect("yes_pressed", self, "_confirm_action")
	menuConfirm.connect("no_pressed", self, "_decline_action")
	$Menu/MenuBody/Buttons/ButtonStart.connect("button_up", self, "_button_start_pressed")
	$Menu/MenuBody/Buttons/ButtonHelp.connect("button_up", self, "_button_help_pressed")
	$Menu/MenuBody/Buttons/ButtonCredits.connect("button_up", self, "_button_credits_pressed")
	$Menu/MenuBody/Buttons/ButtonQuit.connect("button_up", self, "_button_quit_pressed")
	


func _get_configuration_warning() -> String:
	var warning: String = "Starting level must be defined in %s." % name
	return warning if !starting_level else ""


func _button_start_pressed() -> void:
	_set_buttons_active(false)
	Events.emit_signal("load_level", {"target_level": starting_level})
	pass


func _button_help_pressed() -> void:
	# TODO add help screen
	pass


func _button_credits_pressed() -> void:
	# TODO add credits screen
	pass


func _button_quit_pressed() -> void:
	_switch_menu_visibility(false)
	menuConfirm.open_menu()
	action_to_confirm = Actions.QUIT_GAME


func _activate_menu() -> void:
	_set_buttons_active(true)
	_focus_first_button()


func _confirm_action() -> void:
	if action_to_confirm == Actions.QUIT_GAME:
		Events.emit_signal("quit_game")
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