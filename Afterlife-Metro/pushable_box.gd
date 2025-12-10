class_name PushableBox extends RigidBody2D

@export var push_speed : float = 30.0

var push_direction : Vector2 = Vector2.ZERO : set = _set_push

var start_position : Vector2
var start_rotation : float

func _physics_process(_delta: float) -> void:
	linear_velocity = push_direction * push_speed

func _set_push( value : Vector2 ) -> void:
	push_direction = value
	
