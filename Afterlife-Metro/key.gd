extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("human"):   # Only boy can pick up key
		body.has_key = true
		print("Boy picked up the key!")
		queue_free()  # remove the key
