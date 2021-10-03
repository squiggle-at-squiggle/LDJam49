extends CanvasLayer

signal submitted

# Declare member variables here. Examples:
var submission = 0
var submission2 = 0
var submission3 = 0
var submission4 = 0
var submission5 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/PlayerScreen.draw_from_puzzle(submission, submission2, submission3, submission4, submission5)
	$MessageBox.create_message("THIS IS A TEST")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Submit_pressed():
	$ButtonPressSound.play()
	submission = $Control/SliderOne/HSlider.value
	submission2 = $Control/SliderTwo/HSlider.value
	submission3 = $Control/SliderThree/HSlider.value
	submission4 = $Control/SliderFour/HSlider.value
	submission5 = $Control/SliderFive/HSlider.value
	if submission5 == 0:
		submission5 = -1
	emit_signal("submitted")


func _on_SliderOne_changed():
	$SliderClickSound.play()
	$Control/PlayerScreen.draw_from_puzzle($Control/SliderOne/HSlider.value, 
		$Control/SliderTwo/HSlider.value, $Control/SliderThree/HSlider.value,
		$Control/SliderFour/HSlider.value, $Control/SliderFive/HSlider.value)

func _on_SliderTwo_changed():
	$SliderClickSound.play()
	$Control/PlayerScreen.draw_from_puzzle($Control/SliderOne/HSlider.value, 
		$Control/SliderTwo/HSlider.value, $Control/SliderThree/HSlider.value,
		$Control/SliderFour/HSlider.value, $Control/SliderFive/HSlider.value)

func _on_SliderThree_changed():
	$SliderClickSound.play()
	$Control/PlayerScreen.draw_from_puzzle($Control/SliderOne/HSlider.value, 
		$Control/SliderTwo/HSlider.value, $Control/SliderThree/HSlider.value,
		$Control/SliderFour/HSlider.value, $Control/SliderFive/HSlider.value)

func _on_SliderFive_changed():
	$SliderClickSound.play()
	$Control/PlayerScreen.draw_from_puzzle($Control/SliderOne/HSlider.value, 
		$Control/SliderTwo/HSlider.value, $Control/SliderThree/HSlider.value,
		$Control/SliderFour/HSlider.value, $Control/SliderFive/HSlider.value)

func _on_SliderFour_changed():
	$SliderClickSound.play()
	$Control/PlayerScreen.draw_from_puzzle($Control/SliderOne/HSlider.value, 
		$Control/SliderTwo/HSlider.value, $Control/SliderThree/HSlider.value,
		$Control/SliderFour/HSlider.value, $Control/SliderFive/HSlider.value)
