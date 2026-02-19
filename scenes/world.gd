extends Node2D


var peer = ENetMultiplayerPeer.new()
var port = 9992

@onready var canvas1: CanvasLayer = $CanvasLayer

var player = preload("res://scenes/player.tscn")

func _on_host_pressed() -> void:
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(peer_added)
	peer_added(multiplayer.get_unique_id())
	print(multiplayer.get_unique_id())
	canvas1.hide()
	
	
func _on_join_pressed() -> void:
	peer.create_client('localhost', port)
	multiplayer.multiplayer_peer = peer
	canvas1.hide()
	
func peer_added(pid) -> void:
	print('player ' + str(pid) + ' has joined!.')
	var p1 = player.instantiate()
	#p1.position = Vector2(20,-1)
	p1.name = str(pid)
	add_child(p1)
