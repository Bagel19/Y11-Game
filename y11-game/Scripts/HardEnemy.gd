extends Node2D
const bullet_scene = preload("res://Scenes/Bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotator = $Rotator
const rotate_speed = 50
const shooter_timer_wait_time = 0.2
const spawn_point_count = 6
const radius = 100

func _ready() -> void:
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

func _process(delta: float) -> void:
	rotator.rotation_degrees = fmod(rotator.rotation_degrees + rotate_speed * delta, 360.0)

func _on_shoot_timer_timeout() -> void:
	for spawn_point in rotator.get_children():
		var bullet := bullet_scene.instantiate()
		bullet.global_position = spawn_point.get_global_position()
		bullet.global_rotation = spawn_point.get_global_rotation()
		get_tree().current_scene.add_child(bullet)
