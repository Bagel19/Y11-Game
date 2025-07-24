extends Node2D

@export var POWERUP: PackedScene
@export var spawn_bounds: Rect2






func _ready():
	randomize()

func _on_Timer_timeout():
	spawnHealth()

func spawnHealth():
	var chance = randi_range(0,1)
	if chance == 0:
		var powerup = POWERUP.instantiate()
		var rand_x = randf_range(spawn_bounds.position.x, spawn_bounds.position.x + spawn_bounds.size.x)
		var rand_y = randf_range(spawn_bounds.position.y, spawn_bounds.position.y + spawn_bounds.size.y)
		powerup.global_position = Vector2(rand_x, rand_y)
		get_tree().current_scene.add_child(powerup)
	else:
		pass
