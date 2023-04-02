extends CharacterBody2D
class_name Player

signal hit

const SPEED = 300.0
var screen_size

@export var moveData: PlayerMovement
const jump_time_default = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	
	var direction = Input.get_axis("ui_left", "ui_right")		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if (velocity.y > 3000):
#			TODO: game over
			queue_free()
		
		if (velocity.y <= 0):
			animated_sprite.animation = "jump"
		else:
			animated_sprite.animation = "fall"
	else:
		if (velocity.x == 0):
			animated_sprite.animation = "idle"
		else:
			animated_sprite.animation = "run"

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		if Input.is_action_pressed("shift"):
			moveData.jump_time_length = 3.7
			
		animated_sprite.animation = "readyjump"
		
		moveData.jump_time_length += delta
		
	if Input.is_action_just_released("ui_accept") and is_on_floor():
		if (moveData.jump_time_length - jump_time_default) > 0.65:
			moveData.jump_time_length = 5
		
		if moveData.has_super_jump:
			moveData.jump_time_length = 10
			moveData.has_super_jump = false
			
		velocity.y = moveData.jump_velocity * moveData.jump_time_length
		moveData.jump_time_length = 3
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction and not Input.is_action_pressed("ui_accept"):
		if Input.is_action_pressed("shift"):
			velocity.x = direction * SPEED * 2
		else:
			velocity.x = direction * SPEED
		
		if direction == -1:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	position.x = clamp(position.x, 90, screen_size.x)

func set_super_jump():
	moveData.has_super_jump = true

func _on_super_jump_body_entered(body):
	set_super_jump()
