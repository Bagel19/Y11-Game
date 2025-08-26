extends Node2D

var total_time := 120
@onready var PowerUpScene = preload("res://Scenes/HealthUp.tscn")
@onready var timer_label = $CanvasLayer/TimerLabel
@onready var countdown_timer = $CountdownTimer
@onready var player = $Player
@onready var hp_label = $CanvasLayer/HP

func _ready():
	update_timer_label()
	countdown_timer.start()

	var handler = Callable(self, "_on_MAXHP_changed")

	if not player.is_connected("MAXHP_changed", handler):
		player.connect("MAXHP_changed", handler)

	hp_label.text = "HP: %d" % player.MAXHP
	randomize()

func _on_countdown_timer_timeout() -> void:
	total_time -= 1
	update_timer_label()
	
	if total_time <= 0:
		countdown_timer.stop()
		timer_label.text = "Time is Up!"
		get_tree().change_scene_to_file("res://Scenes/WinScreen.tscn")

func update_timer_label():
	var minutes = total_time / 60
	var seconds = total_time % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_MAXPHP_changed(new_health):
	hp_label.text = "HP: %d" % new_health
	print("New HP value:", new_health)

func update_hp_label(current_hp, max_hp):
	hp_label.text = "HP: %d / %d" % [current_hp, max_hp]


func _on_health_timer_timeout() -> void:
	spawn_powerup()

func spawn_powerup():
	var x = randi_range(0, 1150)
	var y = randi_range(0, 645)
	var pos = Vector2(x, y)
	
	var powerup = PowerUpScene.instantiate()
	powerup.global_position = pos
	add_child(powerup)
