extends Node
class_name VisualComponent

@export var animation : AnimationPlayer
@export var input_component : InputComponent
@export var body : CharacterBody2D
@onready var punho: Node2D = $"../PunhoEspada"
@onready var ap: AnimationPlayer = $"../PunhoEspada/AtaquePlayer"
@onready var recarga: Timer = $"../PunhoEspada/Recarga"






var morto : bool = false
var last_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	EventSystem.player_health_change.connect(_on_hit)
	EventSystem.on_player_death.connect(_on_death)

func _process(delta: float) -> void:
	
	if not morto:
		if animation != null and input_component != null and body != null:
			if input_component.direction != Vector2.ZERO:
				last_direction = input_component.direction
				play("running")
			else:
				play("idle")
			
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("atacar") and not morto:
		atacar()
	

func atacar():
	if punho != null and ap != null:
		pass
	var dir_normalizada = normalizar_direcao(last_direction)
	punho.rotation = dir_normalizada.angle()
	ap.play("new_animation")

func normalizar_direcao(dir : Vector2):
	if abs(dir.x) > abs(dir.y):
		if dir.x >= 0:
			return Vector2.RIGHT
		else:
			return Vector2.LEFT
	else:
		if dir.y >= 0:
			return Vector2.DOWN
		else:
			return Vector2.UP


func _on_hit(current : int, max : int):
	if morto:
		return
	recarga.start(0.3)
	animation.play("hit")
	

func _on_death():
	morto = true
	animation.play("death")










func play(type : String):
	var anim = type + "_"
	if abs(last_direction.x) >= abs(last_direction.y):
		if last_direction.x > 0:
			anim += "right"
		else:
			anim += "left"
	else:
		if last_direction.y > 0:
			anim += "down"
		else:
			anim += "up"
	
	animation.play(anim)
