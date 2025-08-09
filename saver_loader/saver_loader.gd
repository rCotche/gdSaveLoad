class_name SaverLoader
extends Node

@onready var player: Player = %Player

func save_game():
	var file = FileAccess.open("user://savegame.data", FileAccess.WRITE)
	
	var saved_data = {}
	saved_data["player_global_position"] = player.global_position
	saved_data["player_health"] = player.health
	
	file.store_var(saved_data)
	file.close()

func load_game():
	var file = FileAccess.open("user://savegame.data", FileAccess.READ)

	var saved_data =file.get_var()
	
	player.health = saved_data["player_health"]
	player.global_position = saved_data["player_global_position"]
	file.close()
