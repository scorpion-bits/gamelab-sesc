extends CharacterBody2D
@onready var animation: AnimationPlayer = $Animation

var is_active : bool
var just_started : bool = true
var tween : Tween

func _physics_process(delta: float) -> void:
	if is_active:
		if just_started:
			teleport(Vector2(0.0,0.0))
			just_started = false
			
func teleport(new_position : Vector2):
	_set_white()
	tween = create_tween()
	tween.tween_property(self, "global_position", new_position, 0.2).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(_set_normal)
	
func _reset_tween():
	if tween:
		tween.kill()
		
func _set_white():
	$Sprite2D.modulate = Color(2.0, 2.0, 2.0, 1.0)
	
func _set_normal():
	var tween = create_tween().tween_property($Sprite2D, "modulate", Color(1,1,1,1), 0.2)
