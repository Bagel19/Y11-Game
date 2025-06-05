extends Node2D

const speed = 100

func _proccess(delta):
	position += transform.x * speed * delta
