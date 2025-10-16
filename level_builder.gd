extends Node

# Preload all section scenes
var medium_sections = [
	preload("res://levels/sections/medium/section_medium_01.tscn"),
	preload("res://levels/sections/medium/section_medium_02.tscn"),
	preload("res://levels/sections/medium/section_medium_03.tscn"),
]

var hard_sections = [
	preload("res://levels/sections/hard/section_hard_01.tscn"),
	preload("res://levels/sections/hard/section_hard_02.tscn"),
	preload("res://levels/sections/hard/section_hard_03.tscn"),
	preload("res://levels/sections/hard/section_hard_04.tscn"),
	preload("res://levels/sections/hard/section_hard_05.tscn"),
	preload("res://levels/sections/hard/section_hard_06.tscn"),
	preload("res://levels/sections/hard/section_hard_07.tscn"),
	preload("res://levels/sections/hard/section_hard_08.tscn"),
]

var veryhard_sections = [
	preload("res://levels/sections/veryhard/section_very_hard_01.tscn"),
	preload("res://levels/sections/veryhard/section_very_hard_02.tscn"),
	preload("res://levels/sections/veryhard/section_very_hard_03.tscn"),
	preload("res://levels/sections/veryhard/section_very_hard_04.tscn"),
	preload("res://levels/sections/veryhard/section_very_hard_05.tscn"),
]

# Configuration
@export var level_length: int = 20  # Number of sections to build
@export var difficulty_curve: bool = true  # Gradually increase difficulty

var current_x_position: float = 100.0  # Starting X position

func _ready():
	build_level()

func build_level():
	print("🏗️ Building level with ", level_length, " sections...")
	
	for i in range(level_length):
		var section = get_next_section(i)
		place_section(section, i)
	
	print("✅ Level complete! Total width:", current_x_position, "px")

func get_next_section(section_index: int) -> PackedScene:
	# Random mix if no difficulty curve
	if not difficulty_curve:
		return get_random_section()
	
	# Calculate progress through level (0.0 to 1.0)
	var progress = float(section_index) / float(level_length)
	
	# Difficulty progression
	if progress < 0.2:  # First 20% - Medium only
		return medium_sections.pick_random()
	
	elif progress < 0.6:  # 20-60% - Mostly Hard, some Medium
		if randf() < 0.7:
			return hard_sections.pick_random()
		else:
			return medium_sections.pick_random()
	
	elif progress < 0.9:  # 60-90% - Hard + Very Hard mix
		if randf() < 0.5:
			return hard_sections.pick_random()
		else:
			return veryhard_sections.pick_random()
	
	else:  # Final 10% - BRUTAL (Very Hard only)
		return veryhard_sections.pick_random()

func get_random_section() -> PackedScene:
	var rand = randf()
	if rand < 0.3:
		return medium_sections.pick_random()
	elif rand < 0.8:
		return hard_sections.pick_random()
	else:
		return veryhard_sections.pick_random()

func place_section(section_scene: PackedScene, index: int):
	# Create instance of section
	var section_instance = section_scene.instantiate()
	
	# Position it at current X
	section_instance.position.x = current_x_position
	section_instance.position.y = 0
	
	# Add to scene (DEFERRED to avoid "busy" error)
	get_parent().call_deferred("add_child", section_instance)  # ⭐ FIXED!
	
	# Update X position for next section
	var end_marker = section_instance.get_node_or_null("EndMarker")
	if end_marker:
		current_x_position += end_marker.position.x
	else:
		# Fallback if no EndMarker found
		current_x_position += 900
	
	print("📍 Section ", index, " (", section_scene.resource_path.get_file(), ") placed at X:", section_instance.position.x)
