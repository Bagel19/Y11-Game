extends Node2D

@export var speed: float = 200.0 

<<<<<<< HEAD
func _proccess(delta):
	position += transform.x * speed * delta



func _on_kill_timer_timeout() -> void:
=======
func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _ready():
	await get_tree().create_timer(5.0).timeout
>>>>>>> 9680d28159d1fcda2b2d551baabb512050451144
	queue_free()
