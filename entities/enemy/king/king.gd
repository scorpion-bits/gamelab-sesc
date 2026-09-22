extends CharacterBody2D

@onready var animation: AnimationPlayer = $Animation
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var health: HealthComponent = $HealthComponent
@onready var teleport_timer: Timer = $TeleportTimer

@export var teleport_time : float = 0.3

var is_active : bool
var just_started : bool = true
var invincibility : bool = false
var tween : Tween

var ghost_interval : float = 0.05
var ghost_duration : float = 0.3

@export var projectile_spawn_interval: float = 0.05
@export var projectile_spawn_duration : float = 2.0
@export var attack_spiral_rotations : int = 3.0
@export var som_dano : AudioStream
var _angle : float = 0.0

func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)
	health.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	print(health.current_health)
	if is_active:
		if just_started:
			teleport(Vector2(0.0,0.0))
			just_started = false
			teleport_timer.start()
			
func teleport(new_position : Vector2):
	_set_white()
	tween = create_tween()
	tween.tween_property(self, "global_position", new_position, teleport_time).set_ease(Tween.EASE_IN_OUT)
	
	var attack_type = randi_range(1,3)
	
	if attack_type == 1:
		tween.tween_callback(attack_1)
	elif attack_type == 2:
		tween.tween_callback(attack_2)
	else:
		tween.tween_callback(attack_2)
	
	
	_create_ghost()
	
func attack_2():
	_set_normal()
	animation.play("attack_down")
	_spawn_projectiles_on_player_direction()

func attack_1():
	_set_normal()
	animation.play("attack_down")
	_angle = 0.0
	_spawn_projectiles()
	
func _spawn_projectiles_on_player_direction():
	var projectile_spawner = create_tween()
	projectile_spawner.set_loops(int(projectile_spawn_duration / projectile_spawn_interval))
	projectile_spawner.tween_interval(projectile_spawn_interval)
	projectile_spawner.tween_callback(_spawn_projectile_on_player_direction)
	
func _spawn_projectile_on_player_direction():
	var projectile_instance = load("res://entities/enemy/king/king_projectile.tscn").instantiate()
	get_tree().get_first_node_in_group("room").add_child(projectile_instance)
	var projectile_tween = create_tween()
	projectile_tween.tween_interval(2.0)
	projectile_tween.tween_callback(projectile_instance.queue_free)
	
	projectile_instance.global_position = global_position
	projectile_instance.speed = 400
	
	projectile_instance.direction = projectile_instance.global_position.direction_to(get_tree().get_first_node_in_group("player").hurtbox_component.global_position)
	

func _spawn_projectiles():
	var projectile_spawner = create_tween()
	projectile_spawner.set_loops(int(projectile_spawn_duration / projectile_spawn_interval))
	projectile_spawner.tween_interval(projectile_spawn_interval)
	projectile_spawner.tween_callback(_spawn_projectile)
	
	
func _spawn_projectile():
	var projectile_instance = load("res://entities/enemy/king/king_projectile.tscn").instantiate()
	get_tree().get_first_node_in_group("room").add_child(projectile_instance)
	var projectile_tween = create_tween()
	projectile_tween.tween_interval(2.0)
	projectile_tween.tween_callback(projectile_instance.queue_free)
	
	projectile_instance.global_position = global_position
	projectile_instance.direction = Vector2.RIGHT.rotated(_angle)
	
	_angle += attack_spiral_rotations * TAU / (projectile_spawn_duration / projectile_spawn_interval)
	
func _reset_tween():
	if tween:
		tween.kill()
		
func  _on_died():
	is_active = false
	teleport_timer.stop()
	CameraSystem.target = self
	animation.play("defeated")

func _on_hit(source: HitboxComponent) -> void:
	if is_active:
		_flash()
		animation.play("damage_taken")
		health.take_damage(source.damage)
		if som_dano != null:
			AudioManager.play_sfx(som_dano)
	
#visual functions

func _create_ghost():
	var spawner = create_tween()
	spawner.set_loops(max(1,int(teleport_time / ghost_interval)))
	spawner.tween_callback(_create_copies)
	spawner.tween_interval(ghost_interval)
	
func _create_copies():
	var copy = Sprite2D.new()
	copy.texture = $Sprite2D.texture
	copy.global_position = $Sprite2D.global_position
	copy.modulate = $Sprite2D.modulate
	copy.hframes = $Sprite2D.hframes
	
	var tween = create_tween()
	tween.tween_property(copy, "modulate", Color(1,1,1,0), ghost_duration)
	tween.tween_callback(copy.queue_free)
	
	get_tree().get_first_node_in_group("room").add_child(copy)

func _set_white():
	$Sprite2D.modulate = Color(2.0, 2.0, 2.0, 1.0)
	
func _set_red():
	$Sprite2D.modulate = Color(7, 1.0, 1.0, 1.0)
	
func _set_normal():
	create_tween().tween_property($Sprite2D, "modulate", Color(1,1,1,1), 0.2)
	
func _flash():
	_set_white()
	_set_normal()

func _on_teleport_timer_timeout() -> void:
	teleport(Vector2(randf_range(-32*5,32*5),randf_range(-32*5,32*5)))
