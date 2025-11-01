class_name GameTree
extends Node 

@onready var gui_mgr: GuiMgr = $GuiMgr

@onready var start_connect_menu: StartConnectMenu = $GuiMgr/StartConnectMenu
@onready var enet_server: EnetServer = $ServerInterface/EnetServer
@onready var server_connector: ServerConnector = $ServerInterface/ServerConnector
@onready var players_mgr: PlayerMgr = $PlayersMgr


func _ready() -> void:
	gui_mgr.gui_host_game.connect(enet_server.start_server)
	gui_mgr.gui_join_game.connect(server_connector.connect_to_server)
	enet_server.spawn_player_for_host.connect(players_mgr.spawn_player_for_host)
