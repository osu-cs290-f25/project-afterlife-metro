extends Control

@onready var ip_input = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit_IPAddress

func _on_host_button_pressed():
	var mp = load("res://Scripts/MultiplayerManager.tscn").instantiate()
	get_tree().root.add_child(mp)
	mp.host_game()
	print("Hosting game...")

func _on_join_button_pressed():
	var ip = ip_input.text
	var mp = load("res://Scripts/MultiplayerManager.tscn").instantiate()
	get_tree().root.add_child(mp)
	mp.join_game(ip)
	print("Joining game at ", ip)

# —— YOUR ROLE SELECTION BUTTONS STILL HERE ——

func _on_button_human_boy_pressed():
	GameManager.role = "human"
	GameManager.gender = "boy"
	_start_game()

func _on_button_human_girl_pressed():
	GameManager.role = "human"
	GameManager.gender = "girl"
	_start_game()

func _on_button_ghost_pressed():
	GameManager.role = "ghost"
	GameManager.gender = ""
	_start_game()


func _start_game():
	get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")
