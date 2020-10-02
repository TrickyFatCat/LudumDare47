#* This is a simple damage detector which is used to detect incoming damage

extends Area2D
class_name DamageDetector

signal get_damage(damage)

var is_active : bool = true setget _set_is_active
var is_invulnerable : bool = false setget _set_is_invulnerable


func _init() -> void:
	connect("area_entered", self, "_on_area_entered")
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: KinematicBody2D) -> void:
	if not is_invulnerable:
		emit_signal("get_damage", body.damage)
	
	if body is Projectile:
		body.destroy()


func get_damage(damage: int) -> void:
	if not is_invulnerable:
		emit_signal("get_damage", damage)


func _set_is_active(value: bool) -> void:
	is_active = value
	monitorable = value
	monitoring = value


func _set_is_invulnerable(value: bool) -> void:
	is_invulnerable = value