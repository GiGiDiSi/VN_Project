extends "res://Scripts/Draggable.gd"
class_name Ingredient

@export var raw_texture: Texture2D
@export var chopped_texture: Texture2D

enum State { WHOLE, CHOPPED }
var current_state: State = State.WHOLE
var is_on_chopping_board: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	_update_visuals()

func _on_area_entered(other_area: Area2D) -> void:
	_check_and_chop(other_area)

func _check_and_chop(other_area: Area2D) -> void:
	if not is_on_chopping_board:
		return
		
	# Foolproof identification pass
	var is_knife = other_area is Knife or other_area.has_method("is_knife_tool")

	if is_knife and current_state == State.WHOLE:
		transition_to_state(State.CHOPPED)
		print("Chopped")
		get_node("/root/Chopping_Demo").ingredient_chopped()

func _on_board_state_changed() -> void:
	if is_on_chopping_board and current_state == State.WHOLE:
		for overlapping_area in get_overlapping_areas():
			_check_and_chop(overlapping_area)
			

func transition_to_state(new_state: State) -> void:
	current_state = new_state
	if not sprite_2d:
		sprite_2d = get_node_or_null("Sprite2D")
	_update_visuals()


func _update_visuals() -> void:
	if not sprite_2d:
		return
		
	match current_state:
		State.WHOLE:
			sprite_2d.texture = raw_texture
		State.CHOPPED:
			sprite_2d.texture = chopped_texture
