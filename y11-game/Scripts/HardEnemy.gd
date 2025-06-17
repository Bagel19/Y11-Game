extends Node2D
var bullet_scene = preload("res://Scenes/Bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotator = $Rotator
var rotate_speed = 50
var shooter_timer_wait_time = 0.2
var spawn_point_count = 6
var radius = 100
var seconds = 0
var minutes = 0
var Dseconds = 0
var Dminutes = 2

func _ready():
	var step = TAU / spawn_point_count
	for i in spawn_point_count:
		var spawn_point := Node2D.new()
		spawn_point.position = Vector2(radius, 0).rotated(step * i)
		spawn_point.rotation = spawn_point.position.angle()
		rotator.add_child(spawn_point)
	for spawn_point in rotator.get_children():
		var bullet = bullet_scene.instantiate()
		bullet.global_transform = spawn_point.global_transform
		get_tree().current_scene.add_child(bullet)
	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	shoot_timer.start()
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 59

func _process(delta: float) -> void:
	var new_rotation = rotator.rotation_degrees + rotate_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout() -> void:
	for s in rotator.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
	#rotator.rotation_degrees = fmod(rotator.rotation_degrees + rotate_speed * delta, 360.0)
