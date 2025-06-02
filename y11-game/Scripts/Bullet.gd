extends Node2D

const speed = 100

func _process(delta):
	position += transform.x * speed * delta

func _on_kill_timer_timeout() -> void:
	queue_free()

#func _on_Area2D_body_entered(body):
	#if body.name == "Player":
		#get_tree().reload_current_scene()
