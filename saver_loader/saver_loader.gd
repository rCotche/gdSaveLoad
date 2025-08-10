class_name SaverLoader
extends Node

@onready var player: Player = %Player
@onready var world_root: WorldRoot = %WorldRoot

func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.player_health = player.health
	saved_game.player_position = player.global_position
	
	#parcours les nodes qui sont dasn le groupe fish dans la scene
	for fish in get_tree().get_nodes_in_group("fish"):
		#append : ajoute l'element à la fin de l'Array
		saved_game.fish_positions.append(fish.global_position)
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	var saved_game = load("user://savegame.tres") as SavedGame
	
	player.health = saved_game.player_health
	player.global_position = saved_game.player_position
	
	#CLEAR
	#parcours les nodes qui sont dasn le groupe fish dans la scene
	for fish in get_tree().get_nodes_in_group("fish"):
		#Bonne pratique :  d'abord remove le node, puis queue free
		fish.get_parent().remove_child(fish)
		fish.queue_free()
	
	for position in saved_game.fish_positions:
		var fish = preload("res://fish/fish.tscn")
		var new_fish = fish.instantiate()
		
		world_root.add_child(new_fish)
		new_fish.global_position = position
