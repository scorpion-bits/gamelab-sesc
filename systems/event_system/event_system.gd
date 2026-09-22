extends Node

signal dialogue_started
signal dialogue_finished

signal player_health_change(current_health : int, max_health : int)
signal king_health_changed(current_health : int, max_health : int)
signal on_player_death
