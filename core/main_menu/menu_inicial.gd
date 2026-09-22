extends CanvasLayer

@export var som_hover : AudioStream
@export var som_pressed : AudioStream

@onready var menu_buttons: VBoxContainer = $MarginContainer/VBoxContainer/MenuButtons
@onready var start_button: Button = $MarginContainer/VBoxContainer/MenuButtons/StartButton

func _ready() -> void:
	for button in menu_buttons.get_children():
		if button is Button:
			button.mouse_entered.connect(_on_button_hovered.bind(button))
			button.focus_entered.connect(_on_button_focused.bind(button))
			button.focus_exited.connect(_on_button_unfocused.bind(button))
			button.mouse_exited.connect(_on_button_unfocused.bind(button))
			button.pressed.connect(_on_any_button_pressed)
	start_button.grab_focus()
	_on_button_focused(start_button)

func _on_any_button_pressed() -> void:
	if som_pressed != null:
		AudioManager.play_sfx(som_pressed)

func _on_button_focused(button: Button) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(button, "scale", Vector2(1.1, 1.1), 0.15)
	tween.parallel().tween_property(button, "position:x", 15.0, 0.15)
	if som_hover != null:
		AudioManager.play_sfx(som_hover)

func _on_button_unfocused(button: Button) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(button, "scale", Vector2(1.0, 1.0), 0.15)
	tween.parallel().tween_property(button, "position:x", 0.0, 0.15)

func _on_button_hovered(button: Button) -> void:
	button.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://core/game_root/game_root.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://core/credits/credits.tscn")
