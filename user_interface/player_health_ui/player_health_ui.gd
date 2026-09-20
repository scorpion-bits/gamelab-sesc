extends Control

@onready var bar: TextureProgressBar = $TextureProgressBar

func _ready() -> void:
	EventSystem.player_health_change.connect(_on_player_health_change)


func _on_player_health_change(current_health : int, max_health : int):
	bar.value = current_health
	bar.max_value = max_health
