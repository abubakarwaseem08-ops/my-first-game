extends Node2D

var score = 0

@onready var game_over_ui = $GameOverUI

func _ready():
	update_score_label()

func increment_score(amount):
	score += amount
	update_score_label()

func update_score_label():
	if $UI/ScoreLabel:
		$UI/ScoreLabel.text = "Score: " + str(score)

# ⭐ NEW FUNCTION — Called when player dies
func trigger_game_over():
	if game_over_ui:
		game_over_ui.show_game_over(score)
