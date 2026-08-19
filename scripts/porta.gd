extends Area2D

func abrir_porta():
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Olá player!  seja bem vindo :0")


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Tchau adeus corpo!  nunca mais nos veremos :0")
