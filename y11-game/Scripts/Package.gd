extends Area2D
var Pickedup = false
var PickupZone = null

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		PickupZone = body
	if Input.is_action_just_pressed("pickup"):
		pick_up_item()

func pick_up_item():
	Pickedup = true
	self.position = PickupZone.position
	self.visible = false
