extends Control

signal time_up

# Declare member variables here. Examples:
var time_remaining


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_timer(initial_time):
	time_remaining = initial_time
	
	
func increase_time(increase_amount):
	time_remaining += increase_amount
