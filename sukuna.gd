extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Stop player movement immediately
		if body.has_method("stop_movement"):
			body.stop_movement()
		
		# Play Game Over sound (while reloading)
		var sound = AudioStreamPlayer2D.new()
		sound.stream = preload("res://game-over-arcade-6435.ogg")
		get_tree().current_scene.add_child(sound)
		sound.play()

		# Reload the scene after a short delay (while sound still plays)
		await get_tree().create_timer(0.2).timeout
		get_tree().reload_current_scene()
