extends Node2D

export(NodePath) onready var next_seg = get_node(next_seg) as Node2D
export var active: bool
onready var player = get_node("../player")


func _ready():
	pass


func activate(lastpos: int):
	active = true
	position.y = lastpos - 480


func _process(_delta):
	if active && player.position.y < position.y + get_viewport().size.y:
		active = false
		next_seg.activate(position.y)
		print("NEXT")
