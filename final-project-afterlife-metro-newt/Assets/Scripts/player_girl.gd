extends CharacterBody2D

@export var move_speed: float = 200.0
@onready var anim_sys = $AnimationSystem

var direction: Vector2 = Vector2.ZERO
var player_facing: String = "down"


func _enter_tree():
	set_multiplayer_authority(name.to_int())


@warning_ignore("unused_parameter")
func _physics_process(delta):
	if !is_multiplayer_authority():
		return

	handle_movement()
	handle_animation()


func handle_movement():
	direction = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		direction.y = -1
		player_facing = "up"
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
		player_facing = "down"

	if Input.is_action_pressed("move_right"):
		direction.x = 1
		player_facing = "right"
	elif Input.is_action_pressed("move_left"):
		direction.x = -1
		player_facing = "left"

	velocity = direction.normalized() * move_speed
	move_and_slide()


func handle_animation():
	var anim_name := ""
	var flip_h := false

	if direction != Vector2.ZERO:
		match player_facing:
			"down":  anim_name = "Move_Down"
			"up":    anim_name = "Move_Up"
			"right": 
				anim_name = "Move_left"
				flip_h = true
			"left":  
				anim_name = "Move_left"
	else:
		match player_facing:
			"down":  anim_name = "Idle_Down"
			"up":    anim_name = "Idle_Up"
			"right": 
				anim_name = "Idle_left"
				flip_h = true
			"left":  
				anim_name = "Idle_left"

	anim_sys.rpc("play_animation", anim_name, flip_h)
