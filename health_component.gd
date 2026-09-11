extends Node
class_name HealthComponent

@export var current_health : int = 100
@export var max_health : int = 100

signal health_changed(current_health, max_health)
signal died

func take_damage(damage : int):
	print("tomou dano")
	current_health -= damage
	
	if current_health < 0 or current_health == 0:
		current_health = 0
		died.emit()
	
	health_changed.emit(current_health, max_health)
		
