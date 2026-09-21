extends Node

var cutscene_triggered : bool = false
var timer_out : bool = false

func _on_cutscene_trigger_area_body_entered(body: Node2D) -> void:
	if !cutscene_triggered and body is Player and timer_out:
		cutscene_triggered = true
		get_tree().get_first_node_in_group("player").can_move = false


func _on_cutscene_trigger_timer_timeout() -> void:
	timer_out = true
	print("timer acabous")
