extends Node

@onready var music_player = $"../MusicPlayer"

func _ready():
	if music_player:
		music_player.finished.connect(_on_music_finished)

func _on_music_finished():
	music_player.play()  # Restart when finished
