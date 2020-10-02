#* It's a base entity class, which containg the most basic logic for the player character and enmies

extends KinematicBody2D
class_name Entity

signal spawn
signal death

export(int) var hitpoints_max := 100
export(int) var hitpoints_initial := 100
export(float) var velocity_max := 400
export(float) var acceleration := 2500
export(float) var friction := 2500

var is_invulnerable : bool = false setget set_is_invulnerable
var is_active : bool = true setget set_is_active
var weaponController : WeaponController

onready var hitPoints : HitPoints = $HitPoints
onready var damageDetector : DamageDetector = $DamageDetector
onready var stateMachine : StateMachine = $StateMachine
onready var sprite : FlashingAnimatedSprite = $AnimatedSprite


func set_is_active(value: bool) -> void:
	is_active = value
	sprite.visible = value
	damageDetector.is_active = value
	stateMachine.set_process_unhandled_input(value)
	switch_logic(value)
	
	if weaponController:
		weaponController.is_active = value
		weaponController.visible = false



func switch_logic(value: bool) -> void:
	#* Here you can write logic which will be called on activation and deactivation of the entity
	pass


func set_is_invulnerable(value: bool) -> void:
	is_invulnerable = value
	damageDetector.is_invulnerable = value


func activate_damage_detection() -> void:
	damageDetector.is_active = true


func deactivate_damage_detection() -> void:
	damageDetector.is_active = false


#! DO NOT USE _ready() in inherited classes use ready() instead
func _ready() -> void:
	_connect_signals()
	_apply_parameters()
	ready()
	pass


func ready() -> void:
	#* Here you can write logic which will be called on _ready
	pass


func _on_spawn() -> void:
	#* Here you can write logic which will be called after entity spawn
	pass


func _on_get_damage(damage: int) -> void:
	#* Here you can write logic which will be called after getting damage
	pass


func _on_hitpoints_decreased() -> void:
	#* Here you can write logic which will be called on hitpoitns decreament
	pass


func _on_zero_hitpoints() -> void:
	#* Here you can write logic which will be called on zero hitpoints
	pass


func on_death() -> void:
	#* Here you can write logic which will be called right after exiting Death state
	pass


func get_hitpoints_current() -> int:
	return hitPoints.value


func get_hitpoints_max() -> int:
	return hitPoints.value


func _connect_signals() -> void:
	connect("spawn", self, "_on_spawn")
	damageDetector.connect("get_damage", self, "_on_get_damage")
	hitPoints.connect("value_decreased", self, "_on_hitpoints_decreased")
	hitPoints.connect("value_zero", self, "_on_zero_hitpoints")


func _apply_parameters() -> void:
	hitPoints.value_max = hitpoints_max
	hitPoints.value = hitpoints_initial

	if has_node("WeaponController"):
		weaponController = get_node("WeaponController")
	else:
		push_warning("Entity >> %s << doesn't have a WeaponController node, if it must have one, check its scene" % name)


func _decrease_hitpoints(damage: int) -> void:
	hitPoints.decrease_value(damage)