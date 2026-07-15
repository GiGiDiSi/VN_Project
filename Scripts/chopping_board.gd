extends Area2D

func _ready() -> void:
	# Connect directly to this node's own signals
	area_entered.connect(_set_ingredient_board_state.bind(true))
	area_exited.connect(_set_ingredient_board_state.bind(false))

func _set_ingredient_board_state(area: Area2D, on_board: bool) -> void:
	if area is Ingredient or area.has_method("_on_board_state_changed"):
		area.is_on_chopping_board = on_board
		area._on_board_state_changed()
