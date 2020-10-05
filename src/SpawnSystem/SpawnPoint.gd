extends Position2D
class_name SpawnPoint

onready var sprite : FlashingSprite = $Sprite


func _ready() -> void:
	visible = false


func show() -> void:
	visible = true
	sprite.start_flash(false)
	yield(get_tree().create_timer(2), "timeout")
	hide()


func hide() -> void:
	visible = false
	sprite.stop_flash()