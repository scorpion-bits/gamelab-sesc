extends Node2D
@onready var componente_interacao: InteractionComponent = $ComponenteInteracao
@onready var dialogue_component: DialogueComponent = $DialogueComponent

var has_spoken : bool

func _ready() -> void:
	componente_interacao.interacao = dialogue_component.start_dialogue
	EventSystem.dialogue_started.connect(_on_dialogue_started)
	EventSystem.dialogue_finished.connect(_on_dialogue_finished)

func _on_dialogue_started():
	if componente_interacao.esta_dentro:
		has_spoken = true

func _on_dialogue_finished():
	if has_spoken:
		get_tree().reload_current_scene()
