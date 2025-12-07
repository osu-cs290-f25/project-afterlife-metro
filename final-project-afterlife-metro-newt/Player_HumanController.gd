extends CharacterBody2D

class_name PlayerController

@export var move_speed = 25.0
@export var input_prefix : String = "move"

var direction : Vector2
var sprinting = false
var sprint_multiplyer = 2.0

enum Facing {UP, DOWN, LEFT, RIGHT}
var player_facing : Facing

func _physics_process(delta):
	
	var up = input_prefix + "move_up"
	var down = input_prefix + "move_down"
	var left = input_prefix + "move_left"
	var right = input_prefix + "move_right"
	
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
	velocity = direction * move_speed * delta * 200 * 1.5
	move_and_slide()
