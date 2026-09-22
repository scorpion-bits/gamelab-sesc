extends CanvasLayer

@export var scroll_speed: float = 40.0 
@export var fast_scroll_multiplier: float = 3.0 
@export var next_scene_path: String = "res://core/credits/credits.tscn"

@onready var credits_container: Control = $CreditsContainer
@onready var vbox: VBoxContainer = $CreditsContainer/VBoxContainer

var is_scrolling: bool = true

func _ready() -> void:
	credits_container.position.y = get_viewport().get_visible_rect().size.y

func _process(delta: float) -> void:
	if not is_scrolling:
		return

	var current_speed = scroll_speed
	if Input.is_action_pressed("ui_accept"):
		current_speed *= fast_scroll_multiplier

	credits_container.position.y -= current_speed * delta

	var total_height = vbox.size.y
	if credits_container.position.y < -total_height:
		_end_credits()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_end_credits()

func _end_credits() -> void:
	if not is_scrolling:
		return
	is_scrolling = false
	
	var tween = create_tween()
	tween.tween_property(credits_container, "modulate:a", 0.0, 1.5)
	tween.tween_callback(func(): get_tree().change_scene_to_file(next_scene_path))
