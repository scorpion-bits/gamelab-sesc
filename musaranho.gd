extends Node2D
@onready var componente_interacao: Area2D = $ComponenteInteracao
@onready var dialogue_component: DialogueComponent = $DialogueComponent

func _ready() -> void:
	componente_interacao.interacao = dialogue_component.start_dialogue
