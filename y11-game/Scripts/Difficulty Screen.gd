extends Control
func _ready() -> void:
	get_tree().paused = false

func _on_easy_mode_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/EasyWorld.tscn")

func _on_hard_mode_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/HardWorld.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
