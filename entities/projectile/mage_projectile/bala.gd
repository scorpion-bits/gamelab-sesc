extends HitboxComponent

var RAPIDEZ = 500
var direcao : Vector2 
@export var explosao : PackedScene

func _process(delta: float) -> void:
	global_position += direcao * delta * RAPIDEZ

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		var explosao_instance = explosao.instantiate()
		explosao_instance.global_position = global_position
		get_tree().root.add_child(explosao_instance)
		queue_free()
