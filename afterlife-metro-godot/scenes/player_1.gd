extends CharacterBody2D

const SPEED = 120.0

func _physics_process(delta: float) -> void:
	var input_dir = Vector2.ZERO

	# Read movement input
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Normalize so diagonal speed isn’t faster
	input_dir = input_dir.normalized()

	# Apply velocity
	velocity = input_dir * SPEED
	move_and_slide()
