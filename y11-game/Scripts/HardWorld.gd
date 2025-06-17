extends Node2D

func _on_endof_level_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/Victory.tscn")

func _on_pause_pressed() -> void:
	pass # Replace with function body.
