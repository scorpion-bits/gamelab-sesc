extends StaticBody2D

@onready var bracos: Node2D = $Bracos
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var arma_player: AnimationPlayer = $Bracos/AnimationPlayer
@export var bala_scene : PackedScene
@onready var marker_2d: Marker2D = $Bracos/Marker2D
@onready var recarga: Timer = $Recarga
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var health_component: HealthComponent = $HealthComponent

var morto := false
func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)
	health_component.died.connect(_on_death)

func _process(delta: float) -> void:
	if not morto:
		if bracos.player_ref != null:
			var distX = global_position.direction_to(bracos.player_ref.global_position) 
			if distX.x > 0:
				scale.x = 1
			else:
				scale.x = -1

func atirar():
	arma_player.play("shoot")
	var bala_instance = bala_scene.instantiate()
	bala_instance.global_position = marker_2d.global_position
	bala_instance.direcao = (bracos.player_ref.hurtbox_component.global_position - marker_2d.global_position).normalized()
	bala_instance.rotation = bala_instance.direcao.angle()
	get_tree().root.add_child(bala_instance)

func _on_recarga_timeout() -> void:
	if bracos.player_ref != null and not morto:
		atirar()

func _on_hit(source):
	ap.play("hit")
	health_component.take_damage(source.damage)

func _on_death():
	morto = true
	ap.play("death")
