extends Area2D

var DMG := 1
@export var speed: float = 200.0 

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	await get_tree().create_timer(60.0).timeout
	queue_free()

func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(DMG)
		queue_free()
		print("Damage dealt!")
