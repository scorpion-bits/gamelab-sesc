extends Node2D
class_name Room

@onready var spawn_point: Marker2D = $SpawnPoint

func _ready() -> void:	
	get_tree().get_first_node_in_group("Player").global_position = spawn_point.global_position
