extends Node

# Level signals
signal load_level(msg)
signal restart_level()
signal level_loaded()
signal level_started()
signal level_finished()
signal level_exit()

# Player signals
signal player_spawned()
signal player_dead()
signal player_shoot()
signal player_switched_weapon(weapon_name, ammo_id, ammo_current, ammo_max)
signal player_heal(heal_power)

# Hud signals
# TODO clean these signals, some of them are excessive
signal update_player_hitpoints(hitpoints_new)
signal update_player_ammo(ammo_id, ammo_current)
signal open_menu_pause()
signal close_menu_pause()
signal menu_pause_opened()
signal menu_pause_closed()

# Transition signals
signal transition_started()
signal transition_stopped()
signal transition_screen_opened()
signal transition_screen_closed()

# Game saver signals
signal save_game()
signal load_game()
signal game_saved()
signal game_loaded()

# Other signals
signal restore_ammo(ammo_id, ammo_add)
signal shake_camera(duration, frequency, amplitude, priority)
signal quit_game()
signal input_device_changed(device_index)