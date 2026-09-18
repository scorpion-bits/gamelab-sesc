extends CharacterBody2D
class_name Player

@onready var movement_component: MovementComponent = $MovementComponent
@onready var input_component: InputComponent = $InputComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

var is_alive : bool = true

func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)
	health_component.health_changed.connect(_on_health_change)
	health_component.died.connect(_on_death)

func _physics_process(delta: float) -> void:
	if is_alive:
		movement_component.move(input_component.get_direction(), delta)
		print(health_component.current_health)
	else:
		movement_component.move(Vector2.ZERO,  delta)
		if Input.is_action_just_pressed("restart"):
			Transicionador.transicionar("res://scenes/game.tscn")


func _on_death():
	EventSystem.on_player_death.emit()
	is_alive = false

func _on_health_change(current : int, max : int):
	EventSystem.player_health_change.emit(current, max)

func _on_hit(source):
	health_component.take_damage(source.damage)
	velocity += source.global_position.direction_to(global_position) * source.knockback_force
