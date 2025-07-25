extends CharacterBody2D

var MAXHP = 5
var CURRENTHP = MAXHP
var speed = 200
var item: Node = null  # Item that the player is carrying
@onready var progress_bar: ProgressBar = get_node_or_null("CanvasLayer/ProgressBar")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Movement direction and velocity


func _ready():
	# Initialize any necessary variables or nodes here
	pass

func _process(delta: float) -> void:
	var move_dir := Input.get_vector("Left", "Right", "Up", "Down")
	if move_dir != Vector2.ZERO:
		velocity = move_dir * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func take_damage(amount = 1) -> void:
	CURRENTHP -= amount
	if CURRENTHP <= 0:
		Lose()

# Lose condition (when HP reaches 0)
func Lose():
	get_tree().change_scene_to_file("res://Scenes/LoseScreen.tscn")
