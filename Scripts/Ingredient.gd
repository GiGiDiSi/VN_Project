extends "res://Scripts/Draggable.gd"

@export var ingredient_name: String = "Ingredient"
@export var base_color: Color = Color(0.9, 0.9, 0.9, 1)
@export var chopped: bool = false:
	set(value):
		chopped = value
		_update_visual()

@onready var color_rect: ColorRect = $ColorRect

const WHOLE_SIZE := Vector2(200, 150)
const CHOPPED_SIZE := Vector2(120, 90)


func _ready() -> void:
	super._ready()
	_update_visual()


func _update_visual() -> void:
	if not is_instance_valid(color_rect):
		return
	color_rect.color = base_color
	color_rect.custom_minimum_size = CHOPPED_SIZE if chopped else WHOLE_SIZE


func _on_input_event(_viewport, event, _shape_idx) -> void:
	super._on_input_event(_viewport, event, _shape_idx)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		_try_drop_in_pot()


func _try_drop_in_pot() -> void:
	for area in get_overlapping_areas():
		if area.is_in_group("pot"):
			area.try_add_ingredient(self)
			return
