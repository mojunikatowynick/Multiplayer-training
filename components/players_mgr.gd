class_name PlayerMgr
extends Node
const MULTIPLAYER_CLIENT = preload("res://components/multiplayer_client.tscn")

func _ready() -> void:
	multiplayer.peer_connected.connect(on_peer_connected)


func on_peer_connected(peer_id: int) -> void:
	var player : MultiplayerClient = MULTIPLAYER_CLIENT.instantiate()
	player.name = str(peer_id)
	add_child(player)

func spawn_player_for_host() -> void:
	on_peer_connected(1) # passes the id of server which is ALWAYS 1
