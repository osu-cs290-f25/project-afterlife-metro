extends Area2D

var game_completed := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Only react to players
	if body.is_in_group("players"):
		redirect_to_thank_you()
	

func redirect_to_thank_you():
	# Prevent triggering multiple times
	if game_completed:
		return
	
	game_completed = true
	
	# Pause the game to prevent any further interaction
	get_tree().paused = true
	
	# Notify parent page via postMessage (more reliable across iframe contexts)
	var js_code = "window.parent.postMessage({ type: 'gameCompleted' }, '*');"
	JavaScriptBridge.eval(js_code)
