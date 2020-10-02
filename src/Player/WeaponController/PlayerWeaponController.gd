extends WeaponController

# Array of all player weapons
const WEAPONS := [
	preload("res://content/Weapons/TestWeapon0.tres"),
	preload("res://content/Weapons/TestWeapon1.tres")
]

var slot_active : int = 0
var is_shooting : bool = false
var ammo_id_current : int = 0
var ammo_cost_current : int = 0

# Array of ammo arrays. Ammo array contains 2 numbers 0 - current ammo, 1 - max ammo
var ammo : Array = [
	[10, 10],
	[10, 15]
]
# Array of weapon slots arrays. Weapon slot array contains 0 - weapon index, 1 - slock is unlocked
# TODO think about a better implementation and add some kind of check for bad data
var weapon_slots : Array = [
	[0, true],
	[1, true],
	[-1,true]
]

onready var weapon : Weapon = $BaseWeapon


func _ready() -> void:
	weapon.connect("shoot", self, "_process_shoot")
	yield(GameManager.current_level, "ready")
	_switch_weapon(_get_slot_weapon_id(slot_active))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and _is_enough_ammo():
		is_shooting = true

	if event.is_action_released("shoot") and weapon.mode == Weapon.ShootMode.AUTO and _is_enough_ammo():
		is_shooting = false
		# TODO Add charge logic here
	
	if event.is_action_pressed("choose_weapon_next") or event.is_action_pressed("choose_weapon_previous"):
		_process_weapon_switch_wheel(event) 


func _physics_process(delta: float) -> void:
	match InputManager.current_input_device:
		InputManager.InputDevice.KEYBOARD:
			look_at(get_global_mouse_position())
			pass
		InputManager.InputDevice.GAMEPAD:
			if InputManager.get_analog_right_direction(InputManager.joy_id_current) != Vector2.ZERO:
				rotation = _get_joystick_rotation()
			pass
	
	flip_weapon()
	switch_z_index()


func _process(delta: float) -> void:
	if not _is_enough_ammo() and is_shooting:
		is_shooting = false
		return

	if is_shooting and _is_enough_ammo():
		weapon.process_shoot()

		if weapon.mode == Weapon.ShootMode.SEMI_AUTO:
			is_shooting = false


func get_ammo_current(ammo_id: int) -> int:
	return ammo[ammo_id][0]


func get_ammo_max(ammo_id: int) -> int:
	return ammo[ammo_id][1]


func increase_ammo_current(ammo_id: int, amount: int) -> void:
	ammo[ammo_id][0] += amount
	ammo[ammo_id][0] = min(ammo[ammo_id][0], ammo[ammo_id][1])


func decrease_ammo_current(ammo_id: int, amount: int) -> void:
	ammo[ammo_id][0] -= amount
	ammo[ammo_id][0] = max(ammo[ammo_id][0], 0)


func set_ammo_max(ammo_id: int, new_max: int) -> void:
	if new_max <= 0:
		push_error("Max ammo can't be less or equal 0")
		return
	
	ammo[ammo_id][1] = new_max


func _is_slot_unlocked(weapon_slot_index: int) -> bool:
	return weapon_slots[weapon_slot_index][1]


func _get_slot_weapon_id(weapon_slot_index: int) -> int:
	return weapon_slots[weapon_slot_index][0]
 

func _process_shoot() -> void:
	decrease_ammo_current(ammo_id_current, ammo_cost_current)
	Events.emit_signal("shake_camera")
	Events.emit_signal("player_shoot", ammo_id_current, get_ammo_current(ammo_id_current))


func _switch_weapon(weapon_id: int) -> void:
	if weapon_id < 0 or weapon_id > WEAPONS.size() - 1:
		var error_text := "A weapon with id %s hasn't been found." % weapon_id
		push_error(error_text)
		return
	
	var weapon_parameters = WEAPONS[weapon_id]
	weapon.apply_parameters(weapon_parameters)
	ammo_id_current = weapon_parameters.ammo_type
	ammo_cost_current = weapon_parameters.ammo_cost
	# TODO reconsider data in signal
	Events.emit_signal(
		"player_switched_weapon",
		weapon_parameters.weapon_name,
		ammo_id_current,
		get_ammo_current(ammo_id_current),
		get_ammo_max(ammo_id_current)
		)


func _process_weapon_switch_wheel(event: InputEvent) -> void:
	var slot_previous := slot_active
	
	if event.is_action_pressed("choose_weapon_next"):
		slot_active += 1
	
	if event.is_action_pressed("choose_weapon_previous"):
		slot_active -= 1

	if slot_active == weapon_slots.size() or slot_active < 0 or not _is_slot_unlocked(slot_active):
		slot_active = slot_previous
		return

	var weapon_id = _get_slot_weapon_id(slot_active)

	if weapon_id < 0 or weapon_id >= WEAPONS.size():
		slot_active = slot_previous
		return
	
	_switch_weapon(_get_slot_weapon_id(slot_active))


func _get_joystick_rotation() -> float:
	return InputManager.get_analog_right_direction(InputManager.joy_id_current).angle()


func _is_enough_ammo() -> bool:
	var ammo_current = get_ammo_current(ammo_id_current)
	return ammo_current > 0 and ammo_current >= ammo_cost_current
