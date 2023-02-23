extends Node2D

onready var player = get_node("../player")
onready var timer = $obstacle_timer


func _ready():
	randomize()
	timer.connect("timeout", self, "_on_timer_timeout")
	reset_timer()


func _on_timer_timeout():
	generate_obstacle()
	reset_timer()


func reset_timer():
	timer.stop()
	timer.wait_time = rand_range(settings.min_time, settings.max_time)
	timer.start()


func generate_obstacle():
	var lane = randi()%3+1
	var lane_pos
	
	match lane:
		1:
			lane_pos = settings.left_pos
		2:
			lane_pos = settings.mid_pos
		3:
			lane_pos = settings.right_pos
	
	var obstacle_scene = load("res://Scenes/simple_obstacle.tscn")
	var obstacle = obstacle_scene.instance()
	obstacle.position.y = player.position.y-500
	obstacle.position.x = lane_pos
	add_child(obstacle)
