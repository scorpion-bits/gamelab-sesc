extends CharacterBody2D
class_name Player

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var movement_component: MovementComponent = $MovementComponent
@onready var input_component: InputComponent = $InputComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var visual_component: VisualComponent = $VisualComponent


var is_alive : bool = true
var can_move : bool = true
var is_moving : bool = false

func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)
	health_component.health_changed.connect(_on_health_change)
	health_component.died.connect(_on_death)

func _physics_process(delta: float) -> void:
	if not is_alive:
		movement_component.move(Vector2.ZERO, delta)
		if Input.is_action_just_pressed("restart"):
			var sala_atual = get_tree().get_first_node_in_group("room")
			Transicionador.change_room(load(sala_atual.scene_file_path))
			
			is_alive = true
			visual_component.morto = false
			health_component.current_health = health_component.max_health
			health_component.health_changed.emit(health_component.current_health, health_component.max_health)
			
			##if $AnimationPlayer.has_animation("idle_down"):
				##$AnimationPlayer.play("idle_down")
		return
	if not can_move:
		input_component.direction = Vector2.ZERO
		movement_component.move(Vector2.ZERO, delta)
		return 
		
		
	if visual_component.is_attacking:
		movement_component.move(visual_component.last_direction * 0.4, delta)
	else:
		movement_component.move(input_component.get_direction(), delta)

func _on_hit(source):
	health_component.take_damage(source.damage)
	velocity += source.global_position.direction_to(hurtbox_component.global_position) * source.knockback_force

func _on_health_change(current : int, max : int):
	EventSystem.player_health_change.emit(current, max)

func _on_death():
	EventSystem.on_player_death.emit()
	is_alive = false
	visual_component.morto = true 
	$AnimationPlayer.play("death")
