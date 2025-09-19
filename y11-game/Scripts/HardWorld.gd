extends Node2D

var total_deliveries := 0
var delivery_goal := 5
var total_time := 120
@onready var PowerUpScene = preload("res://Scenes/HealthUp.tscn")
@onready var package_label = $CanvasLayer/Package
@onready var timer_label = $CanvasLayer/TimerLabel
@onready var PackageScene = preload("res://Scenes/Package.tscn")
@onready var countdown_timer = $CountdownTimer
@onready var player = $Player
@onready var hp_label = $CanvasLayer/HP
@onready var PowerUps = [
	preload("res://Scenes/HealthUp.tscn"),
	preload("res://Scenes/TimerDown.tscn")
]

func _ready():
	randomize()
	update_timer_label()
	countdown_timer.start()
	update_package_label()

	var handler = Callable(self, "_on_MAXHP_changed")

	if not player.is_connected("MAXHP_changed", handler):
		player.connect("MAXHP_changed", handler)

	hp_label.text = "HP: %d" % player.MAXHP
	for i in range(5):
		SpawnPackage()

func _on_countdown_timer_timeout() -> void:
	total_time -= 1
	update_timer_label()
	
	if total_time <= 0:
		countdown_timer.stop()
		timer_label.text = "Time is Up!"
		get_tree().change_scene_to_file("res://Scenes/LoseScreenHard.tscn")

func update_timer_label():
	var minutes = total_time / 60
	var seconds = total_time % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_MAXdHP_changed(new_health):
	hp_label.text = "HP: %d" % new_health
	print("New HP value:", new_health)

func update_hp_label(current_hp, max_hp):
	hp_label.text = "HP: %d / %d" % [current_hp, max_hp]


func _on_health_timer_timeout() -> void:
	spawn_powerup()

func SpawnPackage():
	var x = randi_range(0, 1149)
	var y = randi_range(125,645)
	var pos = Vector2(x, y)
	
	var package = PackageScene.instantiate()
	package.position = pos
	add_child(package)

func spawn_powerup():
	var x = randi_range(0, 1149)
	var y = randi_range(125,645)
	var pos = Vector2(x, y)
	
	var random_index = randi() % PowerUps.size()
	var powerup_scene = PowerUps[random_index]
	
	var powerup = powerup_scene.instantiate()
	powerup.global_position = pos
	add_child(powerup)

func add_time(seconds: float) -> void:
	if countdown_timer.is_stopped():
		return
	total_time += seconds
	update_timer_label()

func add_delivery():
	total_deliveries += 1
	update_package_label()
	
	if total_deliveries >= delivery_goal:
		get_tree().change_scene_to_file("res://Scenes/WinScreenHard.tscn")

func update_package_label():
	package_label.text = "Packages delivered: %d/%d" % [total_deliveries, delivery_goal]
