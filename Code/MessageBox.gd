extends Node


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func create_message(message, time):
	$Control/Panel/CenteredDisplay.text = message
	$Control/Panel/CenteredDisplay.ALIGN_CENTER
	$Control.show()
	yield(get_tree().create_timer(time), "timeout")
	$Control.hide()
