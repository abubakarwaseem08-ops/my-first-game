extends Control

@onready var play_button = $VBoxContainer/PlayButton
@onready var quit_button = $VBoxContainer/QuitButton

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	# ⭐ Use fade transition!
	SceneTransition.change_scene("res://hehehuhu.tscn")  # 😂

func _on_quit_pressed():
	get_tree().quit()
