extends Area2D

@onready var collect_sound = $CollectSound
@onready var animated_sprite = $AnimatedSprite2D  # ⭐ Changed from Sprite2D
@onready var collision = $CollisionShape2D
@onready var sparkle_particles = $SparkleParticles

func _ready():
	# ⭐ Play spin animation
	if animated_sprite:
		animated_sprite.play("spin")

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Trigger particle effect
		if sparkle_particles:
			sparkle_particles.emitting = true
		
		# Play sound
		if collect_sound:
			collect_sound.play()
		
		# Hide and disable immediately
		if animated_sprite:
			animated_sprite.visible = false
		collision.set_deferred("disabled", true)
		
		# Increment score
		var main = get_tree().current_scene
		if main and main.has_method("increment_score"):
			main.increment_score(1)
		
		# Wait for particles and sound
		await get_tree().create_timer(1.0).timeout
		queue_free()
