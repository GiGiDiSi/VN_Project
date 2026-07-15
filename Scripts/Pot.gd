extends Area2D

signal ingredient_added(ingredient_name: String)
signal all_ingredients_collected

@export var required_ingredients: Array[String] = ["Garlic", "Onion", "Ginger", "Beef"]

var collected: Array[String] = []


func _ready() -> void:
	add_to_group("pot")
	monitoring = true
	monitorable = true


func try_add_ingredient(ingredient) -> bool:
	if not ("chopped" in ingredient) or not ingredient.chopped:
		return false
	if ingredient.ingredient_name in collected:
		return false
	if not ingredient.ingredient_name in required_ingredients:
		return false

	collected.append(ingredient.ingredient_name)
	ingredient_added.emit(ingredient.ingredient_name)
	print("Added ", ingredient.ingredient_name, " to pot (", collected.size(), "/", required_ingredients.size(), ")")
	ingredient.queue_free()

	if collected.size() >= required_ingredients.size():
		all_ingredients_collected.emit()
		print("Done")

	return true
