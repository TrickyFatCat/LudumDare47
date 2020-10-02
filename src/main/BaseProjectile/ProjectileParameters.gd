#* This is a projectile resource which contains parameters for projectiles
#* If you want to add a new projectile, create a new resource in the engine and adjust parameters

extends Resource
class_name ProjectileParameters

#* General parameters
export(Texture) var sprite : Texture

#* Basic movement parameters
export(int, "LINEAR", "ACCELERATED", "DECELERATED") var motion_type
export(float) var velocity_initial := 5.0
export(float) var velocity_max := 100.0
export(float) var acceleration := 100.0
export(float) var friction := 100.0

#* Bounce parameters
export(bool) var is_bounceable := false
export(int, "NORMAL", "ACCELERATED", "DECELERATED") var bounce_type
export(float) var bounce_velocity_factor = 1.0
export(float) var bounce_direction_noise = 40.0

#* Spawned scene parameters
export(String, FILE, "*.tscn") var spawned_scene_path
export(String, FILE, "*.tres") var spawned_scene_resource
export(int) var scenes_number := 1

#* Damage parameters
var damage : int = 1