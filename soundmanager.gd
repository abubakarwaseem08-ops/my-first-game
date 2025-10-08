extends Node

# Play a sound anywhere, completely independent
func play_sound(stream: AudioStream):
	if not stream:
		return

	# Create a new AudioStreamPlayer2D for this sound
	var player := AudioStreamPlayer2D.new()
	player.stream = stream
	player.autoplay = false
	player.bus = "Master"
	
	# Add it to the SceneTree root so it survives scene reloads
	get_tree().root.add_child(player)

	# Play the sound
	player.play()

	# Free the player automatically when finished
	player.finished.connect(Callable(player, "queue_free"))

	# Safety: also free after 10 seconds in case finished signal fails
	var timer = get_tree().create_timer(10.0)
	await timer.timeout
	if is_instance_valid(player):
		player.queue_free()
