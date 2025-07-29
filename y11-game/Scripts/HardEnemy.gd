extends Node2D
var bullet_scene = preload("res://Scenes/Bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotator = $Rotator
@onready var pattern_timer = $PatternTimer

var shooter_timer_wait_time = 0.2

var patterns = [
	{"spawn_point_count": 6, "radius": 100, "rotate_speed": 50},
	{"spawn_point_count": 8, "radius": 120, "rotate_speed": 100},
	{"spawn_point_count": 12, "radius": 80, "rotate_speed": 30},
]
var current_pattern_index = 0

func _ready():
	shoot_timer.wait_time = shooter_timer_wait_time
	if not shoot_timer.timeout.is_connected(_on_shoot_timer_timeout):
		shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	shoot_timer.start()

	pattern_timer.wait_time = 60
	pattern_timer.one_shot = false
	if not pattern_timer.timeout.is_connected(_on_pattern_timer_timeout):
		pattern_timer.timeout.connect(_on_pattern_timer_timeout)
	pattern_timer.start()

	setup_spawn_points()

func setup_spawn_points():
	clear_spawn_points()
	var pattern = patterns[current_pattern_index]
	var spawn_point_count = pattern.spawn_point_count
	var radius = pattern.radius
	var step = TAU / spawn_point_count
	for i in range (spawn_point_count):
		var spawn_point = Node2D.new()
		spawn_point.position = Vector2(radius, 0).rotated(step * i)
		spawn_point.rotation = spawn_point.position.angle()
		rotator.add_child(spawn_point)

func clear_spawn_points():
	for child in rotator.get_children():
		rotator.remove_child(child)
		child.queue_free()

func _process(delta: float) -> void:
	var pattern = patterns[current_pattern_index]
	var new_rotation = rotator.rotation_degrees + pattern.rotate_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout() -> void:
	for s in rotator.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

func _on_pattern_timer_timeout():
	current_pattern_index = (current_pattern_index + 1) % patterns.size()
	setup_spawn_points()
