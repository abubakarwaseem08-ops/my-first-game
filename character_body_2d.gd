extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = 400.0
@export var gravity: float = 900.0

func _ready():
	print("Player ready")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		print("In air")
	else:
		# If on floor, stop vertical movement
		velocity.y = 0
		print("Standing on floor")

	# Horizontal movement
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed

	# Jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
		print("Jump")

	# Move and slide (built-in floor detection)
	move_and_slide()
