extends Control

func _on_easy_mode_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/EasyWorld.tscn")

func _on_hard_mode_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/HardWorld.tscn")
