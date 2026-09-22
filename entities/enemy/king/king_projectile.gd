extends HitboxComponent

@export var speed : float = 200.0
@export var direction : Vector2

var bounce_amount : int = 0
var bounce_count : int = 0
var duration : float = 2.0

var time : float = 0.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	time += delta
	
	if time >= duration:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if !bounce_amount:
		queue_free()
	else:
		direction = global_position.direction_to(body.global_position)
		bounce_amount -= 1
		
func set_color_blue():
	$Sprite2D2.show()
	$Sprite2D.hide()
	
func set_color_red():
	$Sprite2D2.hide()
	$Sprite2D.show()
