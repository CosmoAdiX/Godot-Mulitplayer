extends Node2D


var peer = ENetMultiplayerPeer.new()
var port = 9992

func _on_host_pressed() -> void:
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(peer_added)
	
	
func _on_join_pressed() -> void:
	peer.create_client('localhost', port)
	multiplayer.multiplayer_peer = peer
	
func peer_added(pid) -> void:
	print('player ' + str(pid) + ' has joined!.')
