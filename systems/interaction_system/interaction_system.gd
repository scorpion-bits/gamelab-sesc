extends Node

var player : Player
var closest_area : InteractionComponent
var area_list : Array[InteractionComponent] = []

func _ready() -> void:
	EventSystem.dialogue_started.connect(_on_dialogue_started)
	EventSystem.dialogue_finished.connect(_on_dialogue_finished)
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	if area_list.size() > 0:
		area_list.sort_custom(_sort_by_distance)
		area_list[0].pop_interaction_animation()
		
		for i in range(area_list.size()):
			if i == 0:
				area_list[i].is_closest = true
			else:
				area_list[i].is_closest = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and area_list.size() > 0:
		area_list[0].interacao.call()
		get_viewport().set_input_as_handled()

func register_area(nova_area : InteractionComponent):
	if area_list.find(nova_area) == -1:
		area_list.push_back(nova_area)

func unregister_area(area : InteractionComponent):
	area.unpop_interaction_animation()
	var achado = area_list.find(area)
	if achado == -1: # não achou nada na lista
		return
	area_list.remove_at(achado)

func distance_to_player(area : InteractionComponent) -> float:
	var dist = area.global_position.distance_to(get_tree().get_first_node_in_group("player").global_position)
	return dist
	
func _sort_by_distance(a : InteractionComponent, b : InteractionComponent) -> bool:
	if distance_to_player(a) < distance_to_player(b):
		return true
	return false
	
func _on_dialogue_started():
	set_process_unhandled_input(false)
	
func _on_dialogue_finished():
	set_process_unhandled_input(true)
