extends Node

# the three lanes, positions on the screen
var left_pos
var right_pos
var mid_pos
var lane_width = 64

# left/right movement smoothing for the player
var movement_smoothing = 0.25
var player_speed = 300

func _ready():
	mid_pos = get_viewport().size.x / 2
	left_pos = mid_pos - lane_width
	right_pos = mid_pos + lane_width
