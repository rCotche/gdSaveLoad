class_name SaverLoader
extends Node

@onready var player: CharacterBody3D = %Player

func save_game() -> void:
	var file = FileAccess.open("res://savegame.data", FileAccess.WRITE)
	pass

func load_game() -> void:
	pass
