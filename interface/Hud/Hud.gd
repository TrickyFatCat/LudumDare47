extends CanvasLayer

onready var dataPanelPlayer := $DataPanelPlayer
onready var menuPause := $MenuPause
onready var menuGameOver := $MenuGameOver


func _notification(what: int) -> void:
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		if TransitionScreen.is_transitionig():
			Events.connect("transition_screen_opened", self, "_open_pause_menu", [], CONNECT_ONESHOT)
		elif not menuGameOver.is_active:
			_open_pause_menu()


func _input(event: InputEvent) -> void:
	# TODO update pause controls
	if event.is_action_pressed("ui_exit") and not TransitionScreen.is_transitionig():
		if Utility.is_game_paused():
			_close_pause_menu()
		else:
			_open_pause_menu()
			

func _ready() -> void:
	Events.connect("restart_level", self, "_deactivate_input")    
	Events.connect("level_exit", self, "_deactivate_input")   
	Events.connect("level_finished", self, "_deactivate_input")
	Events.connect("player_dead", self, "_open_menu_gameover")


func _deactivate_input() -> void:
	set_process_input(false)


func _open_pause_menu() -> void:
	Utility.pause_game()
	menuPause.open_menu()
	dataPanelPlayer.is_active = false
	Events.emit_signal("open_menu_pause")


func _close_pause_menu() -> void:
	Utility.unpause_game()
	menuPause.close_menu()
	dataPanelPlayer.is_active = true
	Events.emit_signal("close_menu_pause")


func _open_menu_gameover() -> void:
	menuGameOver.open_menu()
	dataPanelPlayer.is_active = false
	set_process_input(false)