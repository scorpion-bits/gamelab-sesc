extends StaticBody2D

@export var room : PackedScene
@onready var componente_interacao: Area2D = $ComponenteInteracao
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	componente_interacao.interacao = acao_da_porta

func acao_da_porta():
	Transicionador.change_room(room)


func _on_componente_interacao_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("open")


func _on_componente_interacao_body_exited(body: Node2D) -> void:
	if body is Player:
		animation_player.play("close")
