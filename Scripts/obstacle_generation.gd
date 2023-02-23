extends Node2D

onready var player = get_node("../player")
onready var timer = $obstacle_timer
var max_time = 1.5
var min_time = 0.3


func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	reset_timer()

func _on_timer_timeout():
	generate_obstacle()
	reset_timer()

func reset_timer():
	timer.stop()
	timer.wait_time = rand_range(max_time, min_time)
	timer.start()


func generate_obstacle():
	var lane_pos = settings.mid_pos
	var obstacle_scene = load("res://Scenes/tree_obstacle.tscn")
	var obstacle = obstacle_scene.instance()
	obstacle.position.y = player.position.y-500
	obstacle.position.x = lane_pos
	add_child(obstacle)
