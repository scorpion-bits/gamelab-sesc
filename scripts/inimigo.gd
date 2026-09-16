extends StaticBody2D

@onready var bracos: Node2D = $Bracos
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var arma_player: AnimationPlayer = $Bracos/AnimationPlayer
@export var bala_scene : PackedScene
@onready var marker_2d: Marker2D = $Bracos/Marker2D
@onready var recarga: Timer = $Recarga

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
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
	bala_instance.direcao = (bracos.player_ref.global_position - marker_2d.global_position).normalized()
	bala_instance.rotation = bala_instance.direcao.angle()
	get_tree().root.add_child(bala_instance)

func _on_recarga_timeout() -> void:
	if bracos.player_ref != null:
		atirar()
