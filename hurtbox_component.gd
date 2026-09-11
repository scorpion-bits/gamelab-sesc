extends Area2D
class_name HurtboxComponent

signal hit(source)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		hit.emit(area)
