extends Node2D
@onready var componente_interacao: Area2D = $ComponenteInteracao
@onready var dialogue_component: DialogueComponent = $DialogueComponent

func _ready() -> void:
	dialogue_component.dialogue_finished.connect(_on_dialogue_finished)
	componente_interacao.interacao = dialogue_component.start_dialogue


func _on_dialogue_finished():
	var boxes = get_tree().get_nodes_in_group("boxes")
	
	for box in boxes:
		box.reset_position()
