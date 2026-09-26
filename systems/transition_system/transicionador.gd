extends CanvasLayer

@onready var ap: AnimationPlayer = $AnimationPlayer
var is_running : bool

signal screen_hidden
signal screen_shown

func change_room(room : PackedScene):

	if !is_running:
		is_running = true
		ap.play("entrar")
		await ap.animation_finished
		screen_hidden.emit()
		
		get_tree().get_first_node_in_group("room").queue_free()
		get_tree().get_first_node_in_group("room_container").add_child(room.instantiate())
		
		ap.play("sair")
		await  ap.animation_finished
		screen_shown.emit()
		is_running = false
