extends Node

var puzzle = preload("res://Scenes/Puzzle.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func NewGame():
	$StartScreen/Control.hide()
	$EndScreen/Control.hide()
	var instance = puzzle.instance()
	# var instance2 = puzzle.instance()
	add_child(instance)
	# add_child(instance2)


func LoseGame():
	$EndScreen.SetText("You lose!")
	$EndScreen/Control.show()
	yield(get_tree().create_timer(3), "timeout")
	$StartScreen/Control.show()


func WinGame():
	$EndScreen.SetText("You win!")
	$EndScreen/Control.show()
	yield(get_tree().create_timer(3), "timeout")
	$StartScreen/Control.show()


func CheckSubmission():
	if $ControlPanel.submission:
		WinGame()
	else:
		LoseGame()
