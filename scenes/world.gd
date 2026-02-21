class_name World
extends Node2D

var peer = ENetMultiplayerPeer.new()
var port = 9999

@onready var canvas1: CanvasLayer = $CanvasLayer

var player = preload("res://scenes/player.tscn")

@onready var spawner: Node2D = $Spawner

var players: Array[Player] = []

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
	var p1: CharacterBody2D = player.instantiate()
	p1.global_position = spawner.get_child(players.size()).global_position
	players.append(p1)
	p1.name = str(pid)
	add_child(p1)
