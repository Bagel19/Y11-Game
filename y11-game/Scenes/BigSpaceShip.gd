extends Area2D

var required_item: String = "Item"

#func _ready():
	#connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.name == "Player" and body.item != null:
		if body.item.name == required_item:
			if Input.is_action_just_pressed("deliver"):
				deliver_item(body)

func deliver_item(player):
	print("Item delivered!")  
	player.item.queue_free()
	player.item = null
