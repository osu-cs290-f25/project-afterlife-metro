extends Node

const PORT := 7000

func host_game():
	var peer := ENetMultiplayerPeer.new()
	var result := peer.create_server(PORT)

	if result != OK:
		print("Failed to start server")
		return

	print("Server started on port ", PORT)
	multiplayer.multiplayer_peer = peer


func join_game(ip_address: String):
	var peer := ENetMultiplayerPeer.new()
	var result := peer.create_client(ip_address, PORT)

	if result != OK:
		print("Failed to connect to server: ", ip_address)
		return

	print("Client connecting to: ", ip_address)
	multiplayer.multiplayer_peer = peer
