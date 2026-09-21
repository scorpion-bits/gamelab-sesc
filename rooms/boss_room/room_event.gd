extends Node

var cutscene_triggered : bool

func _on_cutscene_trigger_area_body_entered(body: Node2D) -> void:
	if !cutscene_triggered and body is Player:
		print("entrou aq")
