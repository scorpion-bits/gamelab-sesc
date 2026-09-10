extends Node
class_name DialogueComponent

@export var dialogues : Array[DialogueData]

func start_dialogue():
	DialogueSystem.start_dialogue(dialogues)
