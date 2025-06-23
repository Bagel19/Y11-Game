extends CharacterBody2D
@export var health = 10
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar

@export var speed = 200
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
func _process(delta: float) -> void:
	var move = Input.get_vector("Left", "Right", "Up", "Down")
	if move:
		velocity = move * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health

func _on_area_2d_area_entered(area: Area2D) -> void:
	health -= 1
	progress_bar.value = health
