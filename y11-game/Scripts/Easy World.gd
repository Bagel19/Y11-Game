extends Node2D

func _on_endof_level_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/WinScreen.tscn")
