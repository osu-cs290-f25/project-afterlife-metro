extends Control

@export var next_scene_path: String = "res://Assets/Scenes/dialogue scenes + scripts/dialogue_3.tscn"
@export var prev_scene_path: String = "res://Assets/Scenes/dialogue scenes + scripts/dialogue_1.tscn"
func _ready():
	$NextButton.pressed.connect(_on_next_pressed)
	$PrevButton.pressed.connect(_on_prev_pressed)

func _on_next_pressed():
	var next_scene = load(next_scene_path)
	get_tree().change_scene_to_packed(next_scene)

func _on_prev_pressed():
	var prev_scene = load(prev_scene_path)
	get_tree().change_scene_to_packed(prev_scene)
