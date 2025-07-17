extends Area2D
var score = 5

func _on_area_entered(area: Area2D) -> void:
	$"../../Label".text = str("Packages needed to be delivered:", score)
	queue_free()
	#if the player enters a specific area:
		#score -= 1
