extends Node
export(PackedScene) var Puzzle

# Declare member variables here. Examples:
var total_rounds = 3
var round_counter = 0
var current_puzzle
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
	new_round()


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
	
func new_round():
	if round_counter >= 1:
		current_puzzle.queue_free()
	current_puzzle = Puzzle.instance()
	current_puzzle.generate_puzzle($ControlPanel/Control/SliderOne/HSlider.min_value,$ControlPanel/Control/SliderOne/HSlider.max_value)
	add_child(current_puzzle)
	solution1 = current_puzzle.solution
	$Countdown.set_timer(30)
	round_counter += 1
	# destroy current_puzzle
	# create_new_puzzle
	# increment round_counter


func CheckSubmission():
	if int($ControlPanel.submission) == solution1 and total_rounds == round_counter:
		WinGame()
	elif int($ControlPanel.submission) == solution1:
		new_round()
	else:
		LoseGame()
