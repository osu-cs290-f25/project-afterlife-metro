class_name Portal
extends Node2D

@onready var body := $StaticBody2D

var plates_required := 0
var plates_active := 0

func _ready():
	var plates = get_tree().get_nodes_in_group("pressure_plate")
	plates_required = plates.size()

	for p in plates:
		p.activated.connect(_on_plate_activated)
		p.deactivated.connect(_on_plate_deactivated)

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
	
