extends Node
class_name VisualComponent

@export var animation : AnimationPlayer
@export var input_component : InputComponent
@export var body : CharacterBody2D

var last_direction : Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if animation != null and input_component != null and body != null:
		if input_component.direction != Vector2.ZERO:
			last_direction = input_component.direction
			play("running")
		else:
			play("idle")
			
func play(type : String):
	var anim = type + "_"
	if abs(last_direction.x) >= abs(last_direction.y):
		if last_direction.x > 0:
			anim += "right"
		else:
			anim += "left"
	else:
		if last_direction.y > 0:
			anim += "down"
		else:
			anim += "up"
	
	animation.play(anim)
