extends Sprite

var lane = 2 # the middle one
onready var tween = $player_movement_tween


func _ready():
	# set the innitial position of the player
	position.x = settings.mid_pos
	position.y = get_viewport().size.y - settings.lane_width


func _process(delta):
	# auto run movement
	position.y -= settings.player_speed*delta


func _input(event):
	# left and right movement
	if event.is_action_pressed("strafe_right"):
		match lane:
			1:
				tween.interpolate_property(self, "position:x",
				position.x, settings.mid_pos, settings.movement_smoothing,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				
				tween.start()
				
				lane += 1
			2:
				tween.interpolate_property(self, "position:x",
				position.x, settings.right_pos, settings.movement_smoothing,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				
				tween.start()
				
				lane +=1
			3:
				print("cannot move any further right")

	if event.is_action_pressed("strafe_left"):
		match lane:
			1:
				print("cannot move any further left")
			2:
				tween.interpolate_property(self, "position:x",
				position.x, settings.left_pos, settings.movement_smoothing,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				
				tween.start()
				
				lane -=1
			3:
				tween.interpolate_property(self, "position:x",
				position.x, settings.mid_pos, settings.movement_smoothing,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				
				tween.start()
				
				lane -=1
