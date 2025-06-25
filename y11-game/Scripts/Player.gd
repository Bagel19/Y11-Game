extends CharacterBody2D
@export var health: int = 5
@export var speed: float = 200
@onready var progress_bar: ProgressBar = get_node_or_null("CanvasLayer/ProgressBar")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if progress_bar:
		progress_bar.max_value = health
		progress_bar.value = health

func _process(delta: float) -> void:
	var move_dir := Input.get_vector("Left", "Right", "Up", "Down")
	if move_dir != Vector2.ZERO:
		velocity = move_dir * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectiles"):
		health -= 1
		progress_bar.value = health
		if health <= 0:
			get_tree().change_scene_to_file("res://Scenes/LoseScreen.tscn")
