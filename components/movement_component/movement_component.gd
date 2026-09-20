extends Node
class_name MovementComponent

@export var body : CharacterBody2D
@export var max_speed : float = 200.0
@export var acceleration : float = 1200.0
@export var deceleration : float = 12.0

func _ready():
	if body == null:
		print("nao associou um corpo ao componente")

func move(direction : Vector2, delta : float):
	if(direction != Vector2.ZERO):
		body.velocity = body.velocity.move_toward(direction * max_speed, acceleration * delta)
	else:
		body.velocity = body.velocity.lerp(Vector2.ZERO, deceleration * delta)
	body.move_and_slide()
