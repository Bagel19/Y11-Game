extends Node2D
<<<<<<< HEAD
var seconds = 0
var minutes = 0
var Dseconds = 0
var Dminutes = 2
func _process(delta: float) -> void:
	translate(Vector2.DOWN * 30 * delta)



func _on_endof_level_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/Victory.tscn")



func _on_timer_timeout() -> void:
	pass # Replace with function body.
=======

#func _on_endof_level_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#get_tree().change_scene_to_file("res://Scenes/Victory.tscn")
>>>>>>> 9680d28159d1fcda2b2d551baabb512050451144
