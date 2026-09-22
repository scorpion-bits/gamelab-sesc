extends Node

var ui : DialogueUI
var dialogue_count : int = -1
var current_dialogues : Array[DialogueData]

func _ready() -> void:
	EventSystem.dialogue_started.connect(_on_dialogue_started)
	EventSystem.dialogue_finished.connect(_on_dialogue_finished)
	set_process_unhandled_input(false)
	
func register_ui(dialogue_ui : DialogueUI):
	ui = dialogue_ui
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir"):
		get_viewport().set_input_as_handled()
		_next_dialogue()
		
func start_dialogue(dialogues : Array[DialogueData]):
	EventSystem.dialogue_started.emit()
	ui.show()
	dialogue_count = -1
	current_dialogues = dialogues
	_next_dialogue()
	
func _next_dialogue():
	if ui.is_dialogue_playing():
		ui.skip_dialogue_animation()
	elif current_dialogues and dialogue_count + 1 < current_dialogues.size():
		dialogue_count += 1
		ui.play_dialogue(current_dialogues[dialogue_count])
	else:
		ui.hide()
		EventSystem.dialogue_finished.emit()
	
func _on_dialogue_started():
	set_process_unhandled_input(true)
	
func _on_dialogue_finished():
	set_process_unhandled_input(false)
