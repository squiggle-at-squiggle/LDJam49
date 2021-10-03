extends Control

signal time_up

# Declare member variables here. Examples:
var active
# Called when the node enters the scene tree for the first time.
func _ready():
	active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TimerText.text = str(floor($Countdown.time_left))
	if $Countdown.time_left <= 6 && active:
		alarm_on()
	else:
		alarm_off()

func set_timer(initial_time):
	$Countdown.wait_time = initial_time
	$Countdown.start()
	active = true

func increase_time(increase_amount):
	$Countdown.wait_time


func stop_timer():
	$Countdown.stop()

func _on_Countdown_timeout():
	$AudioStreamPlayer.stop()
	emit_signal("time_up")


func alarm_on():
	if !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()


func alarm_off():
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.stop()


func turn_off():
	$AudioStreamPlayer.stop()
	active = false
