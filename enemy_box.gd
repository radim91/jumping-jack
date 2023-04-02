extends CharacterBody2D

func _physics_process(delta):
	var new_pos = Vector2()

	new_pos.x = cos(1) * delta
	new_pos.y = sin(1) * delta
	position = global_position + new_pos
	
	print(position)
