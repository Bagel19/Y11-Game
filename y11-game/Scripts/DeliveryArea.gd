extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player" and body.held_item:
		print("Delivered:", body.held_item.name)
		body.held_item.queue_free()
		body.held_item = null
