extends CharacterBody2D

var direction = Vector2.RIGHT
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var rightEdgeCheck = $EdgeCheck
@onready var leftEdgeCheck = $EdgeCheck2

func _physics_process(delta):
	var found_edge_right = not rightEdgeCheck.is_colliding()
	var found_edge_left = not leftEdgeCheck.is_colliding()
	
	if is_on_wall() or (found_edge_right or found_edge_left):
		direction *= -1
		$AnimatedSprite2D.flip_h = direction.x < 0	
		
	
#	if not is_on_floor():
#		velocity.y += gravity * delta * 100
#		velocity.x = 0
	velocity = direction * 75
	
	move_and_slide()
