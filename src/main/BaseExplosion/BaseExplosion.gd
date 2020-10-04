extends Area2D
class_name Explosion

export(int) var damage := 10


func _on_area_entered(area: Area2D) -> void:
	if area is DamageDetector:
		area.get_damage(damage)


func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()

	
func _ready() -> void:
	$AnimatedSprite.play()
	# TODO Delete this test code
