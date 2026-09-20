extends StaticBody2D

@export var room : PackedScene
@export var is_locked : bool = false
@onready var componente_interacao: Area2D = $ComponenteInteracao
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogue: DialogueComponent = $LockedDialogue

func _ready():
	componente_interacao.interacao = acao_da_porta

func acao_da_porta():
	if is_locked:
		if dialogue:
			dialogue.start_dialogue()
		return
	Transicionador.change_room(room)

func trancar():
	is_locked = true

func destrancar():
	is_locked = false

func _on_componente_interacao_body_entered(body: Node2D) -> void:
	if body is Player && is_locked == false:
		animation_player.play("open")


func _on_componente_interacao_body_exited(body: Node2D) -> void:
	if body is Player && is_locked == false:
		animation_player.play("close")


func _on_manager_puzzle_puzzle_resolvido() -> void:
	destrancar()


func _on_manager_puzzle_puzzle_desfeito() -> void:
	trancar()
