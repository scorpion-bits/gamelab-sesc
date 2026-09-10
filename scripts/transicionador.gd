extends CanvasLayer

@onready var ap: AnimationPlayer = $AnimationPlayer

func transicionar(caminho : String):
	ap.play("entrar")
	await ap.animation_finished
	get_tree().change_scene_to_file(caminho)
	ap.play("sair")
