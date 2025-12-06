extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

# Godot 4 RPC syntax fix
@rpc("any_peer", "call_local")
func play_animation(anim_name: String, flip_h: bool):
	sprite_2d.flip_h = flip_h

	if animation_player.current_animation != anim_name:
		animation_player.play(anim_name)
