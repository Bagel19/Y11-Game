extends CharacterBody2D

var MAXHP = 10
var CURRENTHP := 0 
var held_item: Node = null
var speed = 200
@onready var Hint := get_node("/root/HardWorld/CanvasLayer/Hint")
@onready var progress_bar: ProgressBar = get_node_or_null("CanvasLayer/ProgressBar")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var HP: Label = get_node("/root/HardWorld/CanvasLayer/HP")

signal MAXHP_changed(new_value)

func _ready():
	CURRENTHP = MAXHP
	update_hp_label()
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
	update_hp_label()
	print("Player took damage. HP now:", CURRENTHP)
	if CURRENTHP <= 0:
		Lose()

func Lose():
	get_tree().change_scene_to_file("res://Scenes/LoseScreen.tscn")

func set_MAXHP(value):
	MAXHP = value
	emit_signal("MAXHP_changed", MAXHP)
	
func heal(amount: int = 2):
	CURRENTHP = clamp(CURRENTHP + amount, 0, MAXHP)
	update_hp_label()

func update_hp_label():
	HP.text = "HP: {0} / {1}".format([CURRENTHP, MAXHP])
	print("Label updated ->", HP.text)
