extends Node

@onready var human_spawn = $SpawnPoints/HumanSpawn
@onready var ghost_spawn = $SpawnPoints/GhostSpawn


func _ready():
	var peer_id = multiplayer.get_unique_id()
	var scene_path := ""

	# Determine which character scene to load
	if GameManager.role == "human":
		if GameManager.gender == "boy":
			scene_path = "res://Characters/HumanBoy.tscn"
		else:
			scene_path = "res://Characters/HumanGirl.tscn"

		spawn_player(peer_id, scene_path, human_spawn.global_position)

	elif GameManager.role == "ghost":
		scene_path = "res://Characters/Ghost.tscn"
		spawn_player(peer_id, scene_path, ghost_spawn.global_position)



func spawn_player(peer_id: int, scene_path: String, position: Vector2):
	var scene = load(scene_path)
	var player: CharacterBody2D = scene.instantiate()
	player.name = str(peer_id)  # needed for multiplayer authority
	add_child(player)
	player.global_position = position
