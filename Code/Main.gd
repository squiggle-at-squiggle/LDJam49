extends Node
export(PackedScene) var Puzzle

# Declare member variables here. Examples:
export var time = 0
var total_rounds = 12
var round_counter = 0
var current_puzzle
var solution1
var solution2
var solution3
var solution4
var solution5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = time + (3 * delta)

func NewGame():
	$StartScreen/Control.hide()
	$EndScreen/Control.hide()
	$EngineNoise.play(3)
	new_round()


func LoseGame():
	$EngineNoise.stop()
	$Countdown.turn_off()
	get_tree().call_group("puzzle", "queue_free")
	$EndScreen.SetText("You lose!")
	$EndScreen/Control.show()
	$EndScreen/FailureSound.play()
	yield(get_tree().create_timer(3), "timeout")
	$StartScreen/Control.show()


func WinGame():
	$EngineNoise.stop()
	$Countdown.turn_off()
	get_tree().call_group("puzzle", "queue_free")
	$Countdown.stop_timer()
	$EndScreen.SetText("You win!")
	$EndScreen/Control.show()
	$EndScreen/SuccessSound.play()
	yield(get_tree().create_timer(3), "timeout")
	$StartScreen/Control.show()
	
func new_round():
	if round_counter >= 1:
		current_puzzle.queue_free()
	current_puzzle = Puzzle.instance()
	current_puzzle.generate_puzzle($ControlPanel/Control/SliderOne/HSlider.min_value,$ControlPanel/Control/SliderOne/HSlider.max_value)
	add_child(current_puzzle)
	solution1 = current_puzzle.solution
	solution2 = current_puzzle.solution2
	solution3 = current_puzzle.solution3
	solution4 = current_puzzle.solution4
	solution5 = current_puzzle.solution5
	$Countdown.set_timer(90)
	round_counter += 1
	round_controller()
	
func round_controller():
	if round_counter <= 3:
		$ControlPanel/Control/SliderOne.show()
		#set submissions 2-5 to correct
		$ControlPanel/Control/SliderTwo/HSlider.value = solution2
		$ControlPanel/Control/SliderThree/HSlider.value  = solution3
		$ControlPanel/Control/SliderFour/HSlider.value  = solution4
		$ControlPanel/Control/SliderFive/HSlider.value  = solution5
	if round_counter >= 4 and  round_counter <= 6:
		$ControlPanel/Control/SliderTwo.show()
		#set submissions 3-5 to correct
		$ControlPanel/Control/SliderThree/HSlider.value  = solution3
		$ControlPanel/Control/SliderFour/HSlider.value  = solution4
		$ControlPanel/Control/SliderFive/HSlider.value  = solution5
	if round_counter >= 7 and  round_counter <= 9: 
		$ControlPanel/Control/SliderThree.show()
		#set submissions 3-5 to correct
		$ControlPanel/Control/SliderFour/HSlider.value  = solution4
		$ControlPanel/Control/SliderFive/HSlider.value  = solution5
	if round_counter >= 10 and  round_counter <= 12: 
		$ControlPanel/Control/SliderFour.show()
		$ControlPanel/Control/SliderFive.show()
	
func hide_all_toggles():
	$ControlPanel/Control/SliderTwo/HSlider.hide()
	$ControlPanel/Control/SliderThree/HSlider.hide()
	$ControlPanel/Control/SliderFour/HSlider.hide()
	$ControlPanel/Control/SliderFive/HSlider.hide()

func verify_solution():
	if int($ControlPanel.submission) == solution1 and int($ControlPanel.submission2) == solution2 and int($ControlPanel.submission3) == solution3 and int($ControlPanel.submission4) == solution4 and int($ControlPanel.submission5) == solution5:
		return true
	else:
		return false


func CheckSubmission():
	if verify_solution() and total_rounds == round_counter:
		WinGame()
		round_counter=0
		hide_all_toggles()
	elif verify_solution():
		new_round()
	else:
		LoseGame()
		round_counter=0
		hide_all_toggles()
