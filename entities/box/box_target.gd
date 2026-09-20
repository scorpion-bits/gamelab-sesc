extends Area2D
class_name BoxTarget

signal ativado
signal desativado

var tem_caixa : bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("boxes") and not tem_caixa: 
		tem_caixa = true
		ativado.emit()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("boxes") and tem_caixa: 
		tem_caixa = false
		desativado.emit()
