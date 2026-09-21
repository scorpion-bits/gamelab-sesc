extends Control

@onready var play: TextureButton = $GridContainer/Play


func _ready() -> void:
	play.grab_focus()
	AudioManager.play_music()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")




func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_load_pressed() -> void:
	print("Ainda não temos save")
