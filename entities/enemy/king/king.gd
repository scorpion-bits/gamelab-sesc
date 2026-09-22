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

func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)

func _physics_process(delta: float) -> void:
	if is_active:
		if just_started:
			teleport(Vector2(0.0,0.0))
			just_started = false
			teleport_timer.start()
			
func teleport(new_position : Vector2):
	_set_red()
	tween = create_tween()
	tween.tween_property(self, "global_position", new_position, teleport_time).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(_set_normal)
	_create_ghost()

	
func _reset_tween():
	if tween:
		tween.kill()

func _on_hit(source: HitboxComponent) -> void:
	_flash()
	animation.play("damage_taken")
	health.take_damage(source.damage)
	
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
