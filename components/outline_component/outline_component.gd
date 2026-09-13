extends Node
class_name OutlineComponent 

@export var target : Sprite2D

var outline_material : ShaderMaterial
	
func set_material():
	outline_material = preload("res://shaders/outline_material.tres")
	outline_material.set_shader_parameter("outline_width", 0.0)
	outline_material.set_shader_parameter("outline_color", Color.WHITE)
	
	target.material = outline_material.duplicate()
	
func activate():
	print("ativado")
	target.material.set_shader_parameter("outline_width", 1.0)
	
func deactivate():
	print("desativado")
	target.material.set_shader_parameter("outline_width", 0.0)
