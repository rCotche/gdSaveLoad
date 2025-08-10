class_name SaverLoader
extends Node

@onready var player: Player = %Player
@onready var world_root: WorldRoot = %WorldRoot

func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.player_health = player.health
	saved_game.player_position = player.global_position
	
	var saved_data: Array[SavedData] = []
	#la fonction on_save_game sera appelé sur
	#tous les nodes dans la tree qui appartienent au groupe game_events
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	var saved_game = load("user://savegame.tres") as SavedGame
	
	player.health = saved_game.player_health
	player.global_position = saved_game.player_position
	
	#CLEAR
	get_tree().call_group("game_events", "on_before_load_game")
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		
		world_root.add_child(restored_node)
		
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)
