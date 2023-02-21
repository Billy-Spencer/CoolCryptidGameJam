extends Sprite



var left_pos
var right_pos
var mid_pos
var lane = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	mid_pos = get_viewport().size.x / 2
	position.x = mid_pos
	position.y = get_viewport().size.y / 2
	left_pos = mid_pos - 64
	right_pos = mid_pos + 64


func _input(event):
	if event.is_action_pressed("strafe_right"):
		match lane:
			1:
				position.x = mid_pos
				lane += 1
				print(lane)
			2:
				position.x = right_pos
				lane +=1
				print(lane)
			3:
				print("cannot move any further right")
				print(lane)

	if event.is_action_pressed("strafe_left"):
		match lane:
			1:
				print("cannot move any further left")
				print(lane)
			2:
				position.x = left_pos
				lane -=1
				print(lane)
			3:
				position.x = mid_pos
				lane -=1
				print(lane)
