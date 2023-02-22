extends Node2D

export(NodePath) onready var next_seg = get_node(next_seg) as Node2D
export var active: bool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../player")

func activate(lastpos: int):
	active = true
	position.y = lastpos + 480


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active && player.position.y > position.y + 420:
		active = false
		next_seg.activate(position.y)
		print("NEXT")
