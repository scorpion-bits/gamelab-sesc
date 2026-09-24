extends Node2D
@onready var interaction_component: Area2D = $InteractionComponent
@onready var dialogo_principal: DialogueComponent = $DialogoPrincipal
@onready var dialogo_reset: DialogueComponent = $DialogoReset

var has_spoken : bool = false

func _ready() -> void:
	dialogo_reset.dialogue_finished.connect(_on_dialogue_finished)
	interaction_component.interaction = set_musaranho

func set_musaranho():
	if not has_spoken:
		has_spoken = true
		dialogo_principal.start_dialogue()
	else:
		dialogo_reset.start_dialogue()


func _on_dialogue_finished():
	var boxes = get_tree().get_nodes_in_group("boxes")
	
	for box in boxes:
		box.reset_position()
