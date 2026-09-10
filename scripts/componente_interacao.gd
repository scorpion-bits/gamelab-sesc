extends Area2D

@onready var alerta: Sprite2D = $Alerta
var esta_dentro : bool = false

func _ready():
	EventSystem.dialogue_started.connect(_on_dialogue_started)
	EventSystem.dialogue_finished.connect(_on_dialogue_finished)
	alerta.scale = Vector2.ZERO

var interacao : Callable = func():
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and esta_dentro == true:
		interacao.call()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		esta_dentro = true
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(alerta, "scale", Vector2.ONE , 0.3)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		esta_dentro = false
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(alerta, "scale", Vector2.ZERO , 0.3)

func _on_dialogue_started():
	set_process_unhandled_input(false)
	
func _on_dialogue_finished():
	set_process_unhandled_input(true)
