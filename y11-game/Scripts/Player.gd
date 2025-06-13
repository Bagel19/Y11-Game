extends CharacterBody2D

@export var speed = 200
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
func _process(delta: float) -> void:
	var move = Input.get_vector("Left", "Right", "Up", "Down")
	if move:
		velocity = move * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
