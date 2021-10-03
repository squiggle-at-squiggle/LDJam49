extends Node
export(PackedScene) var Puzzle

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var solution1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func NewGame():
	$StartScreen/Control.hide()
	$EndScreen/Control.hide()
	var instance = Puzzle.instance()
	instance.generate_puzzle($ControlPanel/Control/SliderOne/HSlider.min_value,$ControlPanel/Control/SliderOne/HSlider.max_value)
	add_child(instance)
	solution1 = instance.solution
	$Countdown.set_timer(10)


func LoseGame():
	get_tree().call_group("puzzle", "queue_free")
	$EndScreen.SetText("You lose!")
	$EndScreen/Control.show()
	yield(get_tree().create_timer(3), "timeout")
	$StartScreen/Control.show()


func WinGame():
	get_tree().call_group("puzzle", "queue_free")
	$Countdown.stop_timer()
	$EndScreen.SetText("You win!")
	$EndScreen/Control.show()
	yield(get_tree().create_timer(3), "timeout")
	$StartScreen/Control.show()


func CheckSubmission():
	if int($ControlPanel.submission) == solution1:
		WinGame()
	else:
		LoseGame()
