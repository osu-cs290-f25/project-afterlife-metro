extends CharacterBody2D

class_name PlayerController

@export var move_speed = 25.0
@export var input_prefix : String = "move"

var has_key: bool = false
var direction : Vector2 = Vector2.ZERO
var sprinting = false
var sprint_multiplyer = 2.0

enum Facing {UP, DOWN, LEFT, RIGHT}
var player_facing : Facing

func _physics_process(delta):
	
	var up = input_prefix + "_up"
	var down = input_prefix + "_down"
	var left = input_prefix + "_left"
	var right = input_prefix + "_right"
	
	if Input.is_action_pressed(up):
		direction.y = -1
		player_facing = Facing.UP
	elif Input.is_action_pressed(down):
		direction.y = 1
		player_facing = Facing.DOWN
	else:
		direction.y = 0

	if Input.is_action_pressed(right):
		direction.x = 1
		player_facing = Facing.RIGHT
	elif Input.is_action_pressed(left):
		direction.x = -1
		player_facing = Facing.LEFT
	else:
		direction.x = 0

	direction = direction.normalized()
	velocity = direction * move_speed * delta * 200 * 1.5 * sprint_multiplyer
	move_and_slide()
	
func get_push_direction() -> Vector2:
	match player_facing:
		Facing.UP: return Vector2.UP
		Facing.DOWN: return Vector2.DOWN
		Facing.LEFT: return Vector2.LEFT
		Facing.RIGHT: return Vector2.RIGHT
	return Vector2.ZERO
