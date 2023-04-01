extends Area2D

func _on_body_entered(body):
	print(body)
	if body is Player:
		get_tree().reload_current_scene()
