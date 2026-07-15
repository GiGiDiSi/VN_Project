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
	_generate_temp_textures() 
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

func _on_board_state_changed() -> void:
	if is_on_chopping_board and current_state == State.WHOLE:
		for overlapping_area in get_overlapping_areas():
			_check_and_chop(overlapping_area)

func transition_to_state(new_state: State) -> void:
	current_state = new_state
	_update_visuals()

func _update_visuals() -> void:
	if not sprite_2d:
		return
		
	match current_state:
		State.WHOLE:
			sprite_2d.texture = raw_texture
		State.CHOPPED:
			sprite_2d.texture = chopped_texture

# Remove when there's actual textures
func _generate_temp_textures() -> void:
	if raw_texture == null:
		var raw_image = Image.create(64, 64, false, Image.FORMAT_RGBA8)
		raw_image.fill(Color.GREEN) 
		raw_texture = ImageTexture.create_from_image(raw_image)
		
	if chopped_texture == null:
		var chopped_image = Image.create(64, 64, false, Image.FORMAT_RGBA8)
		chopped_image.fill(Color.RED) 
		chopped_texture = ImageTexture.create_from_image(chopped_image)
