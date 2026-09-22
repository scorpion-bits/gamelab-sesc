extends HitboxComponent

@export var speed : float = 200.0
@export var direction : Vector2

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
