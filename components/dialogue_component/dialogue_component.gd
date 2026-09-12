extends Node
class_name DialogueComponent

signal dialogue_started
signal dialogue_finished

@export var dialogues : Array[DialogueData]

var has_started : bool

func _ready() -> void:
	EventSystem.dialogue_finished.connect(_on_dialogue_finished)

func start_dialogue():
	DialogueSystem.start_dialogue(dialogues)
	has_started = true
	dialogue_started.emit()
	
func _on_dialogue_finished():
	if has_started:
		dialogue_finished.emit()
