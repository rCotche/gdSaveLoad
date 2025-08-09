class_name SaverLoader
extends Node

@onready var player: Player = %Player

func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.player_health = player.health
	saved_game.player_position = player.global_position
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	var save_game = load("user://savegame.tres") as SavedGame
	
	player.health = save_game.player_health
	player.global_position = save_game.player_position
