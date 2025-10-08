extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 900.0
@export var max_jumps: int = 2  # total allowed jumps (1 = normal jump, 2 = double jump)

var jump_count: int = 0

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Reset jump count when player touches floor
		jump_count = 0

	# Jump input
	if Input.is_action_just_pressed("ui_up") and jump_count < max_jumps:
		velocity.y = jump_velocity
		jump_count += 1
		print("Jump! Jump count:", jump_count)

	# Horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	move_and_slide()
