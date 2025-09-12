extends Control

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("Blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("Blur")

func Esc():
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Difficulty Screen.tscn")

func _process(_delta: float) -> void:
	Esc()
