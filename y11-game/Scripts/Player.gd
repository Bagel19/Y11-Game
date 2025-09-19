extends CharacterBody2D
@onready var hint_label = $"../CanvasLayer/Hint"
var MAXHP: int = 10
var CURRENTHP: int = MAXHP
var held_item: Node = null
var speed: int = 200

@onready var Hint := get_node("/root/HardWorld/CanvasLayer/Hint")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var HP: Label = get_node("/root/HardWorld/CanvasLayer/HP")

signal max_hp_changed(new_value)
signal health_changed(current_hp)

func _process(_delta: float) -> void:
	var move_dir := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = move_dir * speed if move_dir != Vector2.ZERO else Vector2.ZERO
	move_and_slide()

func take_damage(amount: int = 1) -> void:
	CURRENTHP = max(CURRENTHP - amount, 0)
	emit_signal("health_changed", CURRENTHP)
	update_hp_label()
	if CURRENTHP <= 0:
		Lose()

func Lose():
	if CURRENTHP <= 0:
		var current_scene = get_tree().current_scene.scene_file_path
		if current_scene == "res://Scenes/HardWorld.tscn":
			get_tree().change_scene_to_file("res://Scenes/LoseScreenHard.tscn")
		elif current_scene == "res://Scenes/EasyWorld.tscn":
			get_tree().change_scene_to_file("res://Scenes/LoseScreenEasy.tscn")

func set_MAXHP(value: int):
	MAXHP = value
	emit_signal("max_hp_changed", MAXHP)
	update_hp_label()

func heal(amount: int = 2):
	CURRENTHP = clamp(CURRENTHP + amount, 0, MAXHP)
	update_hp_label()

func update_hp_label():
	HP.text = "HP: {0} / {1}".format([CURRENTHP, MAXHP])

func add_time(seconds: float) -> void:
	get_parent().add_time(seconds)
