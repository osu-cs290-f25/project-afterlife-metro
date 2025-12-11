extends Area2D

@export var end_scene_path: String = "res://EndGame.tscn"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Only react to players
	if body.is_in_group("players"):
		change_to_end_scene()
	

func change_to_end_scene():
	var end_scene = load(end_scene_path)
	get_tree().change_scene_to_packed(end_scene)
