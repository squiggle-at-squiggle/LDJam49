extends CanvasLayer


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func SetText(text):
	$Control/MessageText.text = text


func ShowScreen():
	$Control.show()
