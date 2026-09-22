extends StaticBody2D

@onready var anim = $AnimationPlayer

func _on_hurtbox_component_hit(source):
	anim.play("hit")
