extends Area2D
var score = 5

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # You can use groups or check for the correct node
		var main = get_tree().get_root().get_node("Main")  # Adjust path as needed
		main.increase_count()
		queue_free()  # Remove the collectable
