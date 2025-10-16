extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var victory_sound = $VictorySound
@onready var collision = $CollisionShape2D

var triggered = false

func _ready():
	# Play flag animation
	if animated_sprite:
		animated_sprite.play("wave")

func _on_body_entered(body):
	if triggered:
		return  # Already triggered
	
	if body.is_in_group("player"):
		triggered = true
		
		# Play victory sound
		if victory_sound:
			victory_sound.play()
		
		# Disable collision so player can't retrigger
		collision.set_deferred("disabled", true)
		
		# Trigger level complete
		var main = get_tree().current_scene
		if main and main.has_method("level_complete"):
			# Wait a moment for dramatic effect
			await get_tree().create_timer(0.5).timeout
			main.level_complete()
