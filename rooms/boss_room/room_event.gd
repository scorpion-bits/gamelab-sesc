extends Node

var cutscene_triggered : bool = false
var timer_out : bool = false
@onready var dialogue_2: DialogueComponent = $"../Dialogue2"
@onready var dialogue_1: DialogueComponent = $"../Dialogue1"
@onready var dialogue_start_timer: Timer = $"../DialogueStartTimer"
@onready var king: CharacterBody2D = $"../King"
@export var musica_do_boss : AudioStream
@export var musica_final : AudioStream
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var dialogue_3: Node = $"../Dialogue3"


func _on_cutscene_trigger_area_body_entered(body: Node2D) -> void:
	if !cutscene_triggered and body is Player and timer_out:
		cutscene_triggered = true
		get_tree().get_first_node_in_group("player").can_move = false
		CameraSystem.smoothing = 2
		CameraSystem.target = get_tree().get_first_node_in_group("boss")
		dialogue_start_timer.start()
		

func _on_cutscene_trigger_timer_timeout() -> void:
	timer_out = true


func _on_dialogue_start_timer_timeout() -> void:
	dialogue_1.start_dialogue()
	

func _on_dialogue_1_dialogue_finished() -> void:
	king.animation.play("hand_up")
	dialogue_2.start_dialogue()

func _on_dialogue_2_dialogue_finished() -> void:
	var player = get_tree().get_first_node_in_group("player")
	CameraSystem.smoothing = 4
	CameraSystem.target = player
	player.can_move = true
	king.is_active = true
	canvas_layer.show()
	if musica_do_boss != null:
		AudioManager.play_music(musica_do_boss)


func _on_dialogue_3_dialogue_finished() -> void:
	var player = get_tree().get_first_node_in_group("player")
	CameraSystem.smoothing = 4
	CameraSystem.target = player
	player.can_move = true


func _on_dialogue_3_dialogue_started() -> void:
	if musica_do_boss != null:
		AudioManager.stop_music()
		AudioManager.play_music(musica_final)
