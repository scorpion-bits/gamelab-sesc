extends Node
class_name PuzzleManager

signal puzzle_resolvido
signal puzzle_desfeito

@export var alvos_do_puzzle : Array[BoxTarget]
var caixas_no_lugar : int = 0

func _ready():
	for alvo in alvos_do_puzzle:
		alvo.ativado.connect(_on_alvo_ativado)
		alvo.desativado.connect(_on_alvo_desativado)

func _on_alvo_ativado():
	caixas_no_lugar += 1
	if caixas_no_lugar == alvos_do_puzzle.size():
		puzzle_resolvido.emit()
		

func _on_alvo_desativado():
	caixas_no_lugar -= 1
	print("caixa saiu -  total no lugar ", caixas_no_lugar)
	
	if caixas_no_lugar < alvos_do_puzzle.size():
		puzzle_desfeito.emit()
