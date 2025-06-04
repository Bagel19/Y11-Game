extends Node2D
const bullet_scene = preload("res://Scenes/Bullet.tscn")
@onready var rotator = $Rotator
@onready var shoot_timer = $"Shoot Timer"

const rotate_speed = 80
const shooter_timer_wait_time = 0.2
const spawn_point_count = 3
const radius = 100

func _ready():
	var step = 2 * PI / spawn_point_count

	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)
	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.start()

func _process(delta: float) -> void:
	var new_rotation = rotator.rotation_degrees + rotate_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout() -> void:
	for s in rotator.get_children():
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
