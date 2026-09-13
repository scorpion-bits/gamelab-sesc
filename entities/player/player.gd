extends CharacterBody2D
class_name Player

@onready var movement_component: MovementComponent = $MovementComponent
@onready var input_component: InputComponent = $InputComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)

func _physics_process(delta: float) -> void:
	movement_component.move(input_component.get_direction(), delta)

func _on_hit(source):
	health_component.take_damage(source.damage)
	velocity += source.global_position.direction_to(global_position) * source.knockback_force
