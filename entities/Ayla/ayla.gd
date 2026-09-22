extends Node2D
@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var dialogue_component: DialogueComponent = $DialogueComponent



func _ready() -> void:
	interaction_component.interacao = dialogue_component.start_dialogue
