extends CharacterBody2D

var direction = Vector2.RIGHT
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	velocity = direction * 75
	
	if is_on_wall_only():
		direction *= -1
	
	if not is_on_floor():
		velocity.y += gravity * delta * 100
		velocity.x = 0
	
	move_and_slide()
