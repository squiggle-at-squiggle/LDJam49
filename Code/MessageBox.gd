extends Node


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func create_message(message, time):
	$Panel/CenteredDisplay.text = message
	$Panel/CenteredDisplay.PRESET_CENTER
	$Panel.show()
	yield(get_tree().create_timer(time), "timeout")
	$Panel.hide()
