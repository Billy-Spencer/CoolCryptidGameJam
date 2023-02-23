extends Sprite

var lane = 2 # the middle one
var running = true
var hunted = false

onready var tween = $player_movement_tween
onready var timer = $stumble_timer


func _ready():
	# set the innitial position of the player
	position.x = settings.mid_pos
	position.y = get_viewport().size.y - settings.lane_width
	timer.connect("timeout", self, "_on_timer_timeout")
	reset_timer()


func _process(delta):
	# auto run movement
	if running:
		position.y -= settings.player_speed*delta


func _input(event):
	# left and right movement
	if running and event.is_action_pressed("strafe_right"):
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
				if settings.debug_text:
					print("cannot move any further right")

	if running and event.is_action_pressed("strafe_left"):
		match lane:
			1:
				if settings.debug_text:
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


func _on_player_collision_area_area_entered(area):
	area.get_parent().remove()
	running = false
	timer.start()
	
	if not hunted:
		hunted = true
		summon_hunter()


func _on_timer_timeout():
	reset_timer()
	running = true


func reset_timer():
	timer.stop()
	timer.wait_time = settings.stumble_time


func summon_hunter():
	pass
