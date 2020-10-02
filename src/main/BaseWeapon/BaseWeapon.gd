extends Node2D
class_name Weapon

signal shoot()

enum ShootMode{
	AUTO,
	SEMI_AUTO
}

enum BulletType{
	PROJECTILE,
	RAYCAST,
	BEAM
}

const RECOIL_POWER : float = 25.0
const RECOVERY_SPEED : float = 0.2
const PROJECTILE_DEFAULT : String = "res://src/main/BaseProjectile/BaseProjectile.tscn"

#* General parameters
var weapon_name : String

#* Damage parameters
var mode : int
var damage : int
var rate_of_fire : float

#* Bullet parameters
var bullet_type : int
var spawn_point : Vector2 = Vector2.ZERO
var bullets_count : int
var projectile_resource : String
var projectile_scene_path : String

#* Spread params
var is_spread_dynamic : bool
var spread_min : float
var spread_max : float
var spread : float
var spread_increase_shift : float
var spread_decrease_shift : float

#* Ammo parameters
var ammo_id : int
var ammo_cost : int

onready var sprite : Sprite = $Sprite
onready var sprite_init_pos : Vector2 = sprite.position
onready var rofTimer : Timer = $RofTimer
onready var chargeTimer : Timer = $ChargeTimer


func _ready() -> void:
	rofTimer.one_shot = true
 

func _physics_process(delta: float) -> void:
	_recover_sprite_position()

	if is_spread_dynamic and spread != spread_min:
		_decrease_spread()


func process_shoot() -> void:
	# TODO Implement shooting logic (raycast, beam)
	# TODO Implement charge logic
	# TODO Implement burst shooting
	if not rofTimer.is_stopped():
		return

	for _i in range(bullets_count):
		_spawn_projectile()

	if is_spread_dynamic:
		_increase_spread()
	
	_apply_recoil()
	rofTimer.start()
	emit_signal("shoot")


func apply_parameters(parameters: WeaponParameters) -> void:
	#* General parameters
	weapon_name = parameters.weapon_name
	sprite.texture = parameters.sprite
	sprite.position = parameters.sprite_offset
	sprite_init_pos = parameters.sprite_offset

	#* Damage parameters
	mode = parameters.shoot_mode
	damage = parameters.damage
	rate_of_fire = parameters.rate_of_fire
	rofTimer.wait_time = 1 / rate_of_fire
	rofTimer.stop()

	#* Bullet  parameters
	bullet_type = parameters.bullet_type
	spawn_point.x = parameters.spawn_offset_x
	bullets_count = parameters.bullets_count

	if parameters.projectile_resource:
		projectile_resource = parameters.projectile_resource
	else:
		push_error("Projectile paramentrs hasn't been found in %s" % weapon_name)
	
	if parameters.projectile_scene_path:
		projectile_scene_path = parameters.projectile_scene_path
	else:
		projectile_scene_path = PROJECTILE_DEFAULT

	#* Spread parameters		
	is_spread_dynamic = parameters.is_spread_dynamic
	spread_min = parameters.spread_min
	spread_max = parameters.spread_max
	spread = spread_min
	spread_increase_shift = parameters.spread_increase_shift
	spread_decrease_shift = parameters.spread_decrease_shift

	#* Ammo parametenrs
	ammo_id = parameters.ammo_type
	ammo_cost = parameters.ammo_cost



func _spawn_projectile() -> void:
	var projectile_scene := load(projectile_scene_path)
	var projectile_instance = projectile_scene.instance()
	var projectile_rotation = _calculate_procjectile_rotation()
	var projectile_spawn_position := global_position + spawn_point.rotated(deg2rad(projectile_rotation))
	var projectile_parameters := load(projectile_resource)
	GameManager.current_level.objects_node.add_child(projectile_instance)
	projectile_instance.global_position = projectile_spawn_position
	projectile_instance.rotation_degrees = projectile_rotation
	projectile_instance.move_direction = Vector2.RIGHT.rotated(projectile_instance.rotation)
	projectile_parameters.damage = damage
	projectile_instance.apply_parameters(projectile_parameters)


func _apply_recoil() -> void:
	sprite.position.x -= RECOIL_POWER


func _recover_sprite_position() -> void:
	sprite.position = lerp(sprite.position, sprite_init_pos, RECOVERY_SPEED)


func _calculate_procjectile_rotation() -> float:
	# TODO add different types of spread (even and random)
	randomize()
	var sperad_noise = rand_range(-spread / 2, spread / 2)
	return global_rotation_degrees + sperad_noise


func _increase_spread() -> void:
	spread += spread_increase_shift
	spread = min(spread, spread_max)


func _decrease_spread() -> void:
	spread -= spread_decrease_shift
	spread = max(spread, spread_min)
