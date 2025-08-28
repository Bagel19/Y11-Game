extends Area2D

var picked_up = false
var pickup_zone = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	if pickup_zone and Input.is_action_just_pressed("PickUp") and not picked_up:
		if pickup_zone.held_item == null:
			pick_up_item()
		else:
			print("Player already holding something!")

func _on_body_entered(body):
	if body.name == "Player":
		pickup_zone = body
		if body.held_item == null:
			body.Hint.text = "Press E to pick up"
		else:
			body.Hint.text = "You already have a package"

func _on_body_exited(body):
	if body == pickup_zone:
		body.Hint.text = ""
		pickup_zone = null

func pick_up_item():
	picked_up = true
	self.position = pickup_zone.position
	self.visible = false
	self.set_deferred("monitoring", false)
	pickup_zone.held_item = self
	pickup_zone.Hint.text = ""
