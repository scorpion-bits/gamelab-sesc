extends Node
class_name MovementComponent

@export var body : CharacterBody2D
@export var max_speed : float = 200

func _ready():
	if body == null:
		print("nao associou um corpo ao componente")

func move(direction : Vector2):
	body.velocity = direction * max_speed
	body.move_and_slide()
