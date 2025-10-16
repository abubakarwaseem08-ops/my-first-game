extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	# Start invisible
	color_rect.visible = false

# Fade to black, change scene, fade in
func change_scene(scene_path: String):
	# Fade out
	color_rect.visible = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	
	# Change scene
	get_tree().change_scene_to_file(scene_path)
	
	# Fade in
	animation_player.play("fade_in")
	await animation_player.animation_finished
	color_rect.visible = false
