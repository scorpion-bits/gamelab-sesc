extends Node2D
@onready var interaction_component: InteractionComponent = $ComponenteInteracao
@onready var dialogue_component: DialogueComponent = $DialogueComponent



func _ready() -> void:
	interaction_component.interaction = dialogue_component.start_dialogue
