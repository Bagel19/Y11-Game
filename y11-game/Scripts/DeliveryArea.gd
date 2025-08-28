extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player" and body.held_item:
		# Remove the item
		body.held_item.queue_free()
		body.held_item = null

		# Show feedback
		body.hint_label.text = "You delivered a package"
		await get_tree().create_timer(2.0).timeout
		body.hint_label.text = ""

		# Update world counter
		var world = get_tree().current_scene
		world.add_delivery()
