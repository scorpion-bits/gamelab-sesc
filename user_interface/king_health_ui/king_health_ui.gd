extends Control

@onready var health_bar: TextureProgressBar = $HealthBar
@onready var white_bar: TextureProgressBar = $WhiteBar

func _ready() -> void:
	EventSystem.king_health_changed.connect(_on_king_health_changed)
	
func _on_king_health_changed(current_health : int, max_health : int):
	health_bar.value = current_health
	health_bar.max_value = max_health
	
	create_tween().tween_property(white_bar, "value", current_health, 0.4).set_ease(Tween.EASE_OUT)
