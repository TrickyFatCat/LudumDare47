extends Resource
class_name WeaponParameters

# TODO need to rethink shoot_mode, bullet_type and ammo type export approach

# General parameters
export(String) var weapon_name := "Name"
export(Texture) var sprite : Texture
export(Vector2) var sprite_offset : Vector2 = Vector2.ZERO

# Damage parameters
export(int, "Auto", "Semiauto") var shoot_mode
export(int) var damage := 1
export(float) var rate_of_fire := 1.0

# Bullet parameters
export(int, "Projectile", "Raycast", "Beam") var bullet_type
export(float) var spawn_offset_x := 0.0
export(int) var bullets_count := 1
export(String, FILE, "*.tscn") var projectile_scene_path
export(String, FILE, "*.tres") var projectile_resource

# Spread parameters
export(bool) var is_spread_dynamic := false
export(float) var spread_min := 10.0
export(float) var spread_max := 10.0
export(float) var spread_increase_shift := 10.0
export(float) var spread_decrease_shift := 10.0

# Ammo parameters
export(int, "Bullet", "Shell") var ammo_type
export(int) var ammo_cost := 1
