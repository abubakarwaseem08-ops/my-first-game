extends CanvasLayer

@onready var final_score_label = $VBoxContainer/FinalScoreLabel
@onready var restart_button = $VBoxContainer/RestartButton
@onready var menu_button = $VBoxContainer/MenuButton  # ⭐ NEW
@onready var quit_button = $VBoxContainer/QuitButton

func _ready():
	visible = false
	
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if menu_button:  # ⭐ NEW
		menu_button.pressed.connect(_on_menu_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_pressed)

func show_game_over(final_score: int):
	if final_score_label:
		final_score_label.text = "Final Score: " + str(final_score)
	
	get_tree().paused = true
	visible = true
	
	# Animation (if you have it)
	# ... your fade-in code

func _on_restart_pressed():
	get_tree().paused = false
	SceneTransition.change_scene("res://hehehuhu.tscn")  # ⭐ With fade! 😂

func _on_menu_pressed():  # ⭐ NEW FUNCTION
	get_tree().paused = false
	SceneTransition.change_scene("res://main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
