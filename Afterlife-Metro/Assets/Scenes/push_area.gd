extends Area2D

var current_player : PlayerController = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(b):
	# If a player enters, remember their controller
	if b is PlayerController:
		current_player = b

	# If a box enters, give it the current player's direction
	if b is PushableBox and current_player:
		b.push_direction = current_player.get_push_direction()

func _on_body_exited(b):
	# If a player leaves, remove controller
	if b is PlayerController:
		current_player = null

	# If box leaves area, stop pushing it
	if b is PushableBox:
		b.push_direction = Vector2.ZERO
