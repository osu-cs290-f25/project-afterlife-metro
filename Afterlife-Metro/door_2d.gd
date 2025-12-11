extends Area2D

var is_unlocked: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if is_unlocked:
		return  # door is already open, do nothing

	if not body.is_in_group("human"):
		return

	if not body.has_key:
		print("Human reached door but has NO key.")
		return

	print("Door unlocked!")
	unlock()


func unlock():
	is_unlocked = true
	print("Unlock called!")

	# Disable the blocking collision DEFERRED
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	
	$AnimationPlayer.play("open")
	
	# Optional visual cue
	if $Sprite2D:
		$Sprite2D.modulate = Color(0.7, 1.0, 0.7)
