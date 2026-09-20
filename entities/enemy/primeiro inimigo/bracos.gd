extends Node2D

var player_ref : Player = null
var detectando := false

func _process(delta: float) -> void:
	if detectando and player_ref != null: 
		look_at(player_ref.global_position)

func _on_deteccao_body_entered(body: Node2D) -> void:
	if body is Player:
		player_ref = body
		detectando = true

func _on_deteccao_body_exited(body: Node2D) -> void:
	if body is Player:
		player_ref = null
		detectando = false
