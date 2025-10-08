extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Play the coin sound using the SoundManager singleton
		if $CollectSound:
			SoundManager.play_sound($CollectSound.stream)
		
		# Increment score in the main scene
		get_tree().current_scene.increment_score(1)
		
		# Remove the coin
		queue_free()
