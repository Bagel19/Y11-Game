extends Area2D
@export var time_to_add: float = 5.0

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# Call a function on the player to add time
		body.add_time(time_to_add)
		queue_free()
