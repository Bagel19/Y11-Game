extends Node2D

var seconds = 0
var minutes = 0
var Dseconds = 0
var Dminutes = 2

func _on_endof_level_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/Victory.tscn")

func _on_timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes -= 1

#$Label.text=String(minutes)+":"+String(seconds)
#pass

func Reset_Timer():
	seconds=Dseconds
	minutes=Dminutes

#func _on_endof_level_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#get_tree().change_scene_to_file("res://Scenes/Victory.tscn")
