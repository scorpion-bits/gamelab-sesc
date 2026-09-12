extends CanvasLayer

@onready var ap: AnimationPlayer = $AnimationPlayer

func change_room(room : PackedScene):
	ap.play("entrar")
	await ap.animation_finished
	
	get_tree().get_first_node_in_group("room").queue_free()
	get_tree().get_first_node_in_group("room_container").add_child(room.instantiate())
	
	ap.play("sair")
