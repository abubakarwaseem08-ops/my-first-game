extends Node

# Play a sound anywhere, independent of scene
func play_sound(stream: AudioStream):
	if not stream:
		return
	
	var player := AudioStreamPlayer.new()  # Changed from AudioStreamPlayer2D
	player.stream = stream
	player.bus = "Master"
	player.process_mode = Node.PROCESS_MODE_ALWAYS  # ⭐ Ignore pause!
	
	get_tree().root.add_child(player)
	player.play()
	
	player.finished.connect(Callable(player, "queue_free"))
	
	# Fallback cleanup
	var timer = get_tree().create_timer(10.0)
	await timer.timeout
	if is_instance_valid(player):
		player.queue_free()
