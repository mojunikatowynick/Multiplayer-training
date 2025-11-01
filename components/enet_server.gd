class_name EnetServer
extends Node

signal spawn_player_for_host

var max_players: int = 16

func start_server(port: int) -> void:
	var network: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	network.create_server(port, max_players)
	
	multiplayer.multiplayer_peer = network
	spawn_player_for_host.emit()

	print("Starting server on port:  ", port)
