extends Node

const speed = 100

func _proccess(delta):
	position += transform.x * speed * delta


func _on_kill_timer_timeout() -> void:
	 queue_free()
