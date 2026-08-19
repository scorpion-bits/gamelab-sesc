extends CharacterBody2D
class_name Player

@onready var movement_component: MovementComponent = $MovementComponent
@onready var input_component: InputComponent = $InputComponent

func _physics_process(delta: float) -> void:
	movement_component.move(input_component.get_direction())
