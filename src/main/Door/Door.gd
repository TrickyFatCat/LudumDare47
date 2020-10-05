tool
extends StaticBody2D
class_name Door


export(bool) var is_locked := false
var is_auto := true

var animation_previous : String

onready var collision := $CollisionShape2D
onready var sprite := $AnimatedSprite
onready var trigger := $PlayerTrigger
onready var lockSprite := $Lock


func _ready() -> void:
	set_is_locked(is_locked)
	sprite.connect("animation_finished", self, "_on_animation_finished")

	if is_auto:
		trigger.connect("player_entered", self, "_open")
	else:
		trigger.is_interactable = not is_auto
		trigger.connect("trigger_activated", self, "_open")
	
	trigger.connect("player_exited", self, "_close")


func _open() -> void:
	if is_locked:
		return

	if sprite.animation == "opening" or sprite.animation == "closing":
		return

	if not is_auto and sprite.animation == "opened" and trigger.is_player_inside:
		return
	
	animation_previous = "closed"
	sprite.play("opening")
	collision.set_deferred("disabled", true)
	
	
func _close() -> void:
	if is_locked and sprite.animation == "closed":
		return
		
	if sprite.animation == "opening" or sprite.animation == "closing":
		return
		
	if not is_auto and sprite.animation == "closed" and not trigger.is_player_inside:
		return
	
	animation_previous = "opened"
	sprite.play("closing")
	collision.set_deferred("disabled", false)
	


func _on_animation_finished() -> void:
	match sprite.animation:
		"opening":
			sprite.animation = "opened"
			
			if not trigger.is_player_inside:
				_close()
			pass
		"closing":
			sprite.animation = "closed"

			if trigger.is_player_inside:
				_open()
			pass


func set_is_locked(value: bool) -> void:
	is_locked = value
	lockSprite.visible = value
