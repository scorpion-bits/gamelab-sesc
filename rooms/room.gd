extends Node2D
class_name Room

@onready var spawn_point: Marker2D = $SpawnPoint
@export var room_music : AudioStream

func _ready() -> void:
	if room_music != null:
		AudioManager.play_music(room_music)
	else:
		AudioManager.stop_music()
	
	print(get_tree().get_first_node_in_group("player"))
	get_tree().get_first_node_in_group("player").global_position = spawn_point.global_position
	CameraSystem.target = get_tree().get_first_node_in_group("player")
	CameraSystem.global_position = get_tree().get_first_node_in_group("player").global_position
