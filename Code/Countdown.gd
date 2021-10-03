extends Control

signal time_up

# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TimerText.text = str(floor($Countdown.time_left))

func set_timer(initial_time):
	$Countdown.wait_time = initial_time
	$Countdown.start()


func increase_time(increase_amount):
	$Countdown.wait_time


func stop_timer():
	$Countdown.stop()

func _on_Countdown_timeout():
	emit_signal("time_up")
