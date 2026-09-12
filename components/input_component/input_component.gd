extends Node
class_name InputComponent

var direction : Vector2 = Vector2.ZERO

func get_direction() -> Vector2:

	direction = Input.get_vector("A","D","W","S")
	return direction
	
