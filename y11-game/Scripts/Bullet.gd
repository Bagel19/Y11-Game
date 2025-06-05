extends Node2D

@export var speed: float = 200.0 

func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _ready():
	await get_tree().create_timer(5.0).timeout
	queue_free()
