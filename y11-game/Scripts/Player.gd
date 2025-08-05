extends CharacterBody2D

var MAXHP = 10
var CURRENTHP := 0 
var held_item: Node = null
var speed = 200

@onready var progress_bar: ProgressBar = get_node_or_null("CanvasLayer/ProgressBar")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var HP = $"../CanvasLayer/HP"

signal MAXHP_changed(new_value)

func _ready():
	CURRENTHP = MAXHP
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
	CURRENTHP = max(CURRENTHP, 0)
	emit_signal("health_changed", CURRENTHP)
	print("Player took damage. HP now:", CURRENTHP)
	if CURRENTHP <= 0:
		Lose()

func Lose():
	get_tree().change_scene_to_file("res://Scenes/LoseScreen.tscn")

func set_MAXHP(value):
	MAXHP = value
	emit_signal("MAXHP_changed", MAXHP)
	
func heal():
	var amount = 2
	CURRENTHP += amount
	CURRENTHP = clamp(CURRENTHP, 0, MAXHP)
	update_hp_label()

func update_hp_label():
	HP.text = "HP: %d / %d" % [CURRENTHP, MAXHP]
