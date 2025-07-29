extends Node2D

var total_time := 120
var handler = Callable(self, "_on_health_changed")
@onready var timer_label = $CanvasLayer/TimerLabel
@onready var countdown_timer = $CountdownTimer
@onready var player = $Player
@onready var hp_label = $CanvasLayer/HP

func _ready():
	update_timer_label()
	countdown_timer.start()
	
	if not player.is_connected("health_changed", handler):
		player.connect("health_changed", handler)
	hp_label.text = "HP: %d" % player.health

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

func _on_health_changed(new_health):
	hp_label.text = "HP: %d" % new_health
