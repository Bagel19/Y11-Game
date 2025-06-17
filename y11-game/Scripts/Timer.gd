extends Control

var seconds = 0
var minutes = 0
var Dseconds = 0
var Dminutes = 2

func _ready():
	Reset_Timer()
	update_label()
	$Timer.timeout.connect(_on_Timer_timeout)
	$Timer.start()

func update_label():
	$Label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

func Reset_Timer():
	seconds = Dseconds
	minutes = Dminutes

func _on_Timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59
		else:
			$Timer.stop()
			return
	else:
		seconds -= 1
	update_label()
