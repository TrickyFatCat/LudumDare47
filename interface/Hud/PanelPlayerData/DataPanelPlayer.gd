#* Simple data panel which shows player's HP and ammo of current weapon
# TODO Rethink this script in the future, it's pretty smelly. 

extends DataPanel

onready var hitpointsData : Label = $PanelHitpoints/HitpointsData
onready var weaponName : Label = $PanelWeapon/WeaponName
onready var ammoData : Label = $PanelWeapon/AmmoData


func _ready() -> void:
	Events.connect("player_took_damage", self, "_update_player_hitpoints")
	Events.connect("player_dead", self, "_update_player_hitpoints", [0])
	Events.connect("player_switched_weapon", self, "_update_weapon_data")
	Events.connect("player_shoot", self, "_update_ammo_data")
	# TODO rethink this moment, it looks like a hack. Consider to add some signal on update player hitpoints
	hitpointsData.update_all_values(GameManager.player.get_hitpoints_current(), GameManager.player.get_hitpoints_max())


func _update_player_hitpoints(hitpoints_new: int) -> void:
	hitpointsData.update_value_current(hitpoints_new)
	pass


func _update_weapon_data(
		weapon_name: String,
		ammo_id: int,
		ammo_current: int,
		ammo_max: int
	) -> void:
	weaponName.text = weapon_name
	ammoData.update_all_values(ammo_current, ammo_max)
	pass


func _update_ammo_data(ammo_id: int, ammo_current) -> void:
	ammoData.update_value_current(ammo_current)
	pass
