class_name Portal
extends Node2D

@onready var body := $StaticBody2D
@onready var area := $Area2D

var plates_required := 0
var plates_active := 0
var game_completed := false

func _ready():
	var plates = get_tree().get_nodes_in_group("pressure_plate")
	plates_required = plates.size()

	for p in plates:
		p.activated.connect(_on_plate_activated)
		p.deactivated.connect(_on_plate_deactivated)
	
	# Connect to the Area2D's body_entered signal if it exists
	if area and area.has_signal("body_entered"):
		area.body_entered.connect(_on_player_entered)

func _on_plate_activated():
	plates_active += 1
	_update_portal()

func _on_plate_deactivated():
	plates_active -= 1
	_update_portal()

func _update_portal():
	if plates_active == plates_required:
		open_portal()
	else:
		close_portal()

func open_portal():
	visible = false
	body.set_collision_layer_value(1, false)

func close_portal():
	visible = true
	body.set_collision_layer_value(1, true)

func _on_player_entered(body_node):
	# Prevent triggering multiple times
	if game_completed:
		return
	
	game_completed = true
	
	# Signal to the parent HTML page via JavaScript
	var js_code = "if(window.parent && window.parent.completeGame) { window.parent.completeGame(); }"
	JavaScriptBridge.eval(js_code)
