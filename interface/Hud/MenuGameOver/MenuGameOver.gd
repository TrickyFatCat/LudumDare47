#* Simple game over menu in which player can restart or exit to a main menu

extends Menu

signal restart_pressed
signal exit_pressed


func _ready() -> void:
    _set_menu_buttons($Menu/Body/Buttons)
    _set_buttons_active(is_active)
    $Menu/Body/Buttons/ButtonRestart.connect("button_up", self, "_button_restart_pressed")
    $Menu/Body/Buttons/ButtonExit.connect("button_up", self, "_button_exit_pressed")


func _button_restart_pressed() -> void:
    _set_buttons_active(false)
    Events.emit_signal("restart_level")


func _button_exit_pressed() -> void:
    _set_buttons_active(false)
    Events.emit_signal("level_exit")