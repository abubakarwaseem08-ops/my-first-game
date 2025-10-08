extends Node2D  # Or your root node type

var score = 0  # Keep track of coins collected

func _ready():
	update_score_label()

# Function to increase score
func increment_score(amount):
	score += amount
	update_score_label()

# Update the UI label
func update_score_label():
	if $UI/ScoreLabel:
		$UI/ScoreLabel.text = "Score: " + str(score)
