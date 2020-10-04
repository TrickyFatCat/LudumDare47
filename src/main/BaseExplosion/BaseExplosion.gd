extends Area2D
class_name Explosion

export(int) var damage := 10
export(float) var radius := 32


func _on_area_entered(area: Area2D) -> void:
	if area is DamageDetector:
		area.get_damage(damage)


func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()

	
func _ready() -> void:
	# $CollisionShape2D.shape.set_deferred("radius", radius)
	$CollisionShape2D.shape.call_deferred("set", "radius", radius)
	# $CollisionShape2D.shape.radius = radius
	$AnimatedSprite.play()
	# yield(get_tree(), "idle_frame")
	# yield(get_tree(), "idle_frame")
	# monitoring = false
	# TODO Delete this test code

