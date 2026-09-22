extends CanvasLayer

@onready var canvas_layer: CanvasLayer = $"."
@onready var continuar: Button = $ColorRect/VBoxContainer/Continuar
@onready var reiniciar: Button = $ColorRect/VBoxContainer/Reiniciar
@onready var menu: Button = $ColorRect/VBoxContainer/VoltarAoMenu


func _ready() -> void:
	visible = false
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		alternar_pausa()

func alternar_pausa() -> void:
	var esta_pausado = not get_tree().paused
	get_tree().paused = esta_pausado
	visible = esta_pausado
	
	if visible:
		continuar.grab_focus() 



func _on_continuar_pressed() -> void:
	alternar_pausa()


func _on_reiniciar_pressed() -> void:
	alternar_pausa() 
	var sala_atual = get_tree().get_first_node_in_group("room")
	if sala_atual != null:
		var cena_sala = load(sala_atual.scene_file_path)
		Transicionador.change_room(cena_sala)


func _on_voltar_ao_menu_pressed() -> void:
	alternar_pausa() 
	get_tree().change_scene_to_file("res://core/main_menu/menu_inicial.tscn")
