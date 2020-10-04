extends WeaponController

export(String, FILE, "*.tres") var weapon_parameters : String

onready var weapon : Weapon = $BaseWeapon


func _ready() -> void:
	if is_active:
		var new_parameters = load(weapon_parameters)
		weapon.apply_parameters(new_parameters)
	else:
		weapon.visible = false


func _physics_process(delta: float) -> void:
	flip_weapon()
	switch_z_index()