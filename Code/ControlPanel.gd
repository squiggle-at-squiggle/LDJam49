extends CanvasLayer

signal submitted

# Declare member variables here. Examples:
var submission = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/PlayerScreen.draw_from_puzzle(submission)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Submit_pressed():
	submission = $Control/SliderOne/HSlider.value
	emit_signal("submitted")


func _on_SliderOne_changed():
	$Control/PlayerScreen.draw_from_puzzle($Control/SliderOne/HSlider.value)
