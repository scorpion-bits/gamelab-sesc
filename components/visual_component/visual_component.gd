extends Node
class_name VisualComponent

@export var animation : AnimationPlayer
@export var input_component : InputComponent
@export var body : CharacterBody2D
@onready var recarga: Timer = $"../Recarga"



var morto : bool = false 
var is_attacking : bool = false
var last_direction : Vector2 = Vector2.DOWN

func _process(delta: float) -> void:
	if not morto and not is_attacking: 
		if animation != null and input_component != null and body != null:
			if input_component.direction != Vector2.ZERO:
				last_direction = input_component.direction
				play("running")
				
			else:
				play("idle")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("atacar") and not morto:
		atacar("attack")

func atacar(type : String):
	is_attacking = true
	play(type)
	await animation.animation_finished 
	is_attacking = false

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

func _on_hit(current : int, max : int):
	if morto:
		return
	recarga.start(0.3)
	animation.play("hit")

func _on_death():
	morto = true
	animation.play("death")
