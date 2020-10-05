extends Position2D
class_name SpawnPoint

onready var sprite : FlashingSprite = $Sprite


func _ready() -> void:
	visible = false


func show() -> void:
	visible = true
	sprite.start_flash(false)
	

func hide() -> void:
	visible = false
	sprite.stop_flash()
