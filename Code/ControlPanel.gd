extends CanvasLayer

signal submitted

# Declare member variables here. Examples:
var submission

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Submit_pressed():
	print("you clicked the button")
	#submission = $Control/TextEdit.text
	#$Control/TextEdit.text = ''
	submission = $Control/SliderOne/HSlider.value
	emit_signal("submitted")
