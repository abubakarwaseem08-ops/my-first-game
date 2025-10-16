extends Area2D

# Reference to the AnimatedSprite2D node
@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	# Play the "idle" animation when the scene starts
	if anim_sprite:
		anim_sprite.play("idle")

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.has_method("stop_movement"):
			body.stop_movement()
		
		# Play Game Over sound
		SoundManager.play_sound(preload("res://game-over-arcade-6435.ogg"))
		
		# ⭐ Trigger Game Over UI instead of instant reload
		var main = get_tree().current_scene
		if main and main.has_method("trigger_game_over"):
			main.trigger_game_over()
