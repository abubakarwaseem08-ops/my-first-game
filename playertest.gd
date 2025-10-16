extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -300.0
@export var gravity: float = 700.0
@export var max_jumps: int = 2

var jump_count: int = 0

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound  # ⭐ NEW
@onready var double_jump_sound = $DoubleJumpSound  # ⭐ NEW

func _ready():
	animated_sprite.play("idle")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Reset jump count when touching floor
		jump_count = 0
	
	# Jump input
	if Input.is_action_just_pressed("ui_up") and jump_count < max_jumps:
		velocity.y = jump_velocity
		jump_count += 1
		
		# ⭐ Play appropriate jump sound
		if jump_count == 1:
			# First jump - normal jump sound
			if jump_sound:
				jump_sound.play()
		elif jump_count == 2:
			# Second jump - double jump sound
			if double_jump_sound:
				double_jump_sound.play()
	
	# Horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	
	# Update animations
	update_animation(direction)
	
	move_and_slide()

func update_animation(direction: float):
	# Flip sprite based on direction
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
	
	# Play appropriate animation
	if not is_on_floor():
		# In the air
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
	else:
		# On the ground
		if direction != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
