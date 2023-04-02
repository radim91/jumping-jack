extends Node2D

var angle = 0

func _physics_process(delta):
	angle += delta 
	$SpikeBox.global_position = $Point.global_position + Vector2.RIGHT.rotated(angle)*200
