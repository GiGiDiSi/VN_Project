extends Area2D

var dragging = false
var of = Vector2(0, 0)


func _ready() -> void:
	get_viewport().physics_object_picking = true
	input_pickable = true


func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			of = get_global_mouse_position() - global_position
		else:
			dragging = false
