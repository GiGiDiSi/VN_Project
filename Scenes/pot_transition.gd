extends Node2D

@onready var garlic_node: Ingredient = $Garlic
@onready var ginger_node: Ingredient = $Ginger
@onready var onion_node: Ingredient = $Onion
@onready var meat_node: Ingredient = $Ingredient

func _ready() -> void:
	force_ingredient_state(garlic_node, IngreTracker.garlic_chopped)
	force_ingredient_state(ginger_node, IngreTracker.ginger_chopped)
	force_ingredient_state(onion_node, IngreTracker.onion_chopped)
	force_ingredient_state(meat_node, IngreTracker.meat_chopped)

func force_ingredient_state(ingredient: Ingredient, is_chopped: bool) -> void:
	if ingredient != null:
		if is_chopped:
			ingredient.transition_to_state(Ingredient.State.CHOPPED)
		else:
			ingredient.transition_to_state(Ingredient.State.WHOLE)
