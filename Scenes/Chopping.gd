extends Node2D

var ingredients_remaining : int = 4

func _ready() -> void:
	pass

func ingredient_chopped() -> void:
	ingredients_remaining -= 1
	print("-1")
	
	if ingredients_remaining <= 0:
		change_to_pot_scene()

func change_to_pot_scene() -> void:
	IngreTracker.garlic_chopped = true
	IngreTracker.ginger_chopped = true
	IngreTracker.onion_chopped = true
	IngreTracker.meat_chopped = true
	
	get_tree().change_scene_to_file("res://Scenes/pot_transition.tscn")
