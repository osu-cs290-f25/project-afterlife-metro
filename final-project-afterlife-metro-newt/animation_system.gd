extends Node2D

@export var player_controller : PlayerController
@export var animation_prefix : String = ""   # "" for boy/girl, "ghost_" for ghost

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D


func _process(delta):
	if player_controller == null:
		return

	sprite_2d.flip_h = false

	if player_controller.velocity.length() > 0.0:
		play_move_animation()
	else:
		play_idle_animation()


func play_move_animation():
	match player_controller.player_facing:
		player_controller.Facing.DOWN:
			animation_player.play(animation_prefix + "move_down")

		player_controller.Facing.UP:
			animation_player.play(animation_prefix + "move_up")

		player_controller.Facing.RIGHT:
			animation_player.play(animation_prefix + "move_left")
			sprite_2d.flip_h = true

		player_controller.Facing.LEFT:
			animation_player.play(animation_prefix + "move_left")


func play_idle_animation():
	match player_controller.player_facing:
		player_controller.Facing.DOWN:
			animation_player.play(animation_prefix + "idle_down")

		player_controller.Facing.UP:
			animation_player.play(animation_prefix + "idle_up")

		player_controller.Facing.RIGHT:
			animation_player.play(animation_prefix + "idle_left")
			sprite_2d.flip_h = true

		player_controller.Facing.LEFT:
			animation_player.play(animation_prefix + "idle_left")
