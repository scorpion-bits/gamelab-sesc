extends Area2D
class_name InteractionComponent

@onready var outline_component: OutlineComponent = $OutlineComponent
@export var target : Node2D

var interaction : Callable
var in_range : bool
var is_closest : bool
var animation_up : bool

func _ready():
	outline_component.target = target
	outline_component.set_material()
	
func _process(delta: float) -> void:
	if in_range and is_closest:
		pop_interaction_animation()
	else:
		unpop_interaction_animation()
	
func pop_interaction_animation():
	if !animation_up:
		outline_component.activate()
		animation_up = true
	
func unpop_interaction_animation():
	if animation_up:
		outline_component.deactivate()
		animation_up = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InteractionSystem.register_area(self)
		in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		InteractionSystem.unregister_area(self)
		in_range = false
