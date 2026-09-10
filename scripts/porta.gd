extends StaticBody2D

@onready var componente_interacao: Area2D = $ComponenteInteracao
@export var caminho : String

func _ready():
	componente_interacao.interacao = acao_da_porta

func acao_da_porta():
	Transicionador.transicionar(caminho)
