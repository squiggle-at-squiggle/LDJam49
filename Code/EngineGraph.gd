extends Node2D

onready var a = 1
onready var b = 15
onready var c = 25
onready var d = 0
onready var e = 1

func _ready():
	update()

func _draw():
	for i in range(700):
		draw_line(Vector2(a*i, b*sin(c*i) + d*cos(e*i)), Vector2(a*(i+1), b*sin(c*(i+1)) + d*cos(e*(i+1))), ColorN("slateblue"), 1)

func draw_from_puzzle( value1 ):
	b = 15 *  value1
	update()
