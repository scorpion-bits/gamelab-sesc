extends Control
class_name DialogueUI
@onready var portrait: Sprite2D = $Portrait
@onready var content: RichTextLabel = $NinePatchRect/Content

var tween : Tween

func _ready() -> void:
	EventSystem.dialogue_started.connect(_on_dialogue_started)
	EventSystem.dialogue_finished.connect(_on_dialogue_finished)
	DialogueSystem.register_ui(self)

func play_dialogue(dialogue_data : DialogueData):
	if dialogue_data.portrait != null:
		portrait.show()
		portrait.texture = dialogue_data.portrait
	else:
		portrait.hide()
	
	content.text = dialogue_data.text
	content.visible_ratio = 0.0
	
	_reset_tween()
	tween = create_tween()
	tween.tween_property(content, "visible_ratio", 1.0, dialogue_data.duration)

func skip_dialogue_animation():
	_reset_tween()
	content.visible_ratio = 1.0

func is_dialogue_playing() -> bool:
	if tween != null:
		return tween.is_running()
	return false
		
func _reset_tween():
	if tween != null:
		tween.kill()
		
func _on_dialogue_started():
	#show()
	pass
	
func _on_dialogue_finished():
	#hide()
	pass
