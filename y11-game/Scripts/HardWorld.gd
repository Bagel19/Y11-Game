extends Node2D

var total_time := 120
@onready var timer_label = $TimerLabel
@onready var countdown_timer = $CountdownTimer

func _ready():
	update_timer_label()
	countdown_timer.start()

func _on_countdown_timer_timeout() -> void:
	total_time-= 1
	update_timer_label()
	
	if total_time <= 0:
