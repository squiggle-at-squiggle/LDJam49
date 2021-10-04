extends Control

signal time_up

# Declare member variables here. Examples:
var active
# Called when the node enters the scene tree for the first time.
func _ready():
	active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$TimerText.text = str(floor($Countdown.time_left))
	if $Countdown.time_left <= 6 && active:
		alarm_on()
	else:
		alarm_off()


func set_timer(initial_time):
	$Countdown.wait_time = initial_time
	$Countdown.start()
	active = true


func increase_time(_increase_amount):
	var increasedAmount = clamp(_increase_amount, 0, 100 - $Countdown.time_left)
	$Countdown.wait_time = $Countdown.time_left + increasedAmount
	$Countdown.start()


func decrease_time(_decrease_amount):
	var decreasedAmount = clamp(_decrease_amount, 0, $Countdown.time_left)
	$Countdown.wait_time = $Countdown.time_left - decreasedAmount
	$Countdown.start()


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
