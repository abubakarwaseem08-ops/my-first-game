extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
var gravity: float = 900.0

func _ready():
	print("Player ready")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		print("in air")
	else:
		print("standing on floor")

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity
		print("jump")

	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	move_and_slide()
