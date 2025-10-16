extends CanvasLayer

@onready var score_label = $VBoxContainer/ScoreLabel
@onready var restart_button = $VBoxContainer/RestartButton
@onready var menu_button = $VBoxContainer/MenuButton
@onready var vbox = $VBoxContainer
@onready var color_rect = $ColorRect

func _ready():
	visible = false
	
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if menu_button:
		menu_button.pressed.connect(_on_menu_pressed)

func show_victory(final_score: int):
	if score_label:
		score_label.text = "Final Score: " + str(final_score)
	
	visible = true
	
	# Animation (same as game over)
	if vbox:
		vbox.modulate.a = 0.0
		vbox.scale = Vector2(0.8, 0.8)
	if color_rect:
		color_rect.modulate.a = 0.0
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)
	
	if color_rect:
		tween.tween_property(color_rect, "modulate:a", 0.8, 0.5)
	if vbox:
		tween.tween_property(vbox, "modulate:a", 1.0, 0.5)
		tween.tween_property(vbox, "scale", Vector2(1.0, 1.0), 0.5)
	
	await tween.finished
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().paused = false
	SceneTransition.change_scene("res://hehehuhu.tscn")

func _on_menu_pressed():
	get_tree().paused = false
	SceneTransition.change_scene("res://ui/main_menu.tscn")
