extends Control

# TODO: Point this actual gameplay scene
const GAME_SCENE_PATH := "res://Scenes/VN_Interface_Demo.tscn"


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE_PATH)


func _on_continue_button_pressed() -> void:
	# TEST
	print("Continue pressed - no save system wired up yet")


func _on_settings_button_pressed() -> void:
	# TODO: Swap to actual settings
	print("Settings pressed - placeholder")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
