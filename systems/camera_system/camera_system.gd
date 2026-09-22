extends Camera2D

var target : Node2D
var smoothing : float = 4

func _ready():
	target = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position, smoothing * delta)
