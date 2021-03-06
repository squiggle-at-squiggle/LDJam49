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
var gameStarted
var creditsOpen

# Called when the node enters the scene tree for the first time.
func _ready():
	gameStarted = false
	creditsOpen = false
	$EngineNoise.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = time + (3 * delta)

func NewGame():
	gameStarted = true
	$ControlPanel/Control/PlayerScreen.hide()
	$ControlPanel/Control/Credits.hide()
	$StartMessage/Control.hide()
	$EndScreen/Control.hide()
	if !$EngineNoise.playing:
		$EngineNoise.play()
	$Countdown.set_timer(90)
	new_round()


func LoseGame():
	round_counter=0
	hide_all_toggles()
	$EngineNoise.stop()
	$Countdown.turn_off()
	get_tree().call_group("puzzle", "queue_free")
	current_puzzle.queue_free()
	$EndScreen.SetText("You lose!")
	$EndScreen/Control.show()
	$EndScreen/FailureSound.play()
	yield(get_tree().create_timer(3), "timeout")
	$EndScreen/Control.hide()
	gameStarted = false
	$ControlPanel/Control/Submit.text = "Engage"
	$StartMessage/Control.show()
	$ControlPanel/Control/Submit.show()
	$ControlPanel/Control/Credits.show()


func WinGame():
	$EngineNoise.stop()
	$Countdown.turn_off()
	get_tree().call_group("puzzle", "queue_free")
	current_puzzle.queue_free()
	$Countdown.stop_timer()
	$EndScreen.SetText("You win!")
	$EndScreen/Control.show()
	$EndScreen/SuccessSound.play()
	yield(get_tree().create_timer(3), "timeout")
	$EndScreen/Control.hide()
	gameStarted = false
	$ControlPanel/Control/Submit.text = "Engage"
	$StartMessage/Control.show()
	$ControlPanel/Control/Submit.show()
	$ControlPanel/Control/Credits.show()
	
func new_round():
	var verb = Verb()
	var message = verb + " the " + TechnoBabble()
	$ControlPanel/Control/Submit.hide()
	$Countdown/Countdown.set_paused(true)
	$MessageBox.create_message(message, 3)
	$ControlPanel/Control/Submit.text = verb
	yield(get_tree().create_timer(3), "timeout")
	$ControlPanel/Control/Submit.show()
	$ControlPanel/Control/PlayerScreen.show()
	$Countdown/Countdown.set_paused(false)
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
	$ControlPanel/Control/SliderOne.hide()
	$ControlPanel/Control/SliderTwo.hide()
	$ControlPanel/Control/SliderThree.hide()
	$ControlPanel/Control/SliderFour.hide()
	$ControlPanel/Control/SliderFive.hide()

func verify_solution():
	if int($ControlPanel.submission) == solution1 and int($ControlPanel.submission2) == solution2 and int($ControlPanel.submission3) == solution3 and int($ControlPanel.submission4) == solution4 and int($ControlPanel.submission5) == solution5:
		return true
	else:
		return false


func CheckSubmission():
	if !gameStarted:
		$ControlPanel/Control/Submit.hide()
		NewGame()
		gameStarted = true
	elif verify_solution() and total_rounds == round_counter:
		$ControlPanel/Control/Submit.hide()
		WinGame()
		round_counter=0
		hide_all_toggles()
	elif verify_solution():
		$ControlPanel/Control/Submit.hide()
		$Correct.play()
		$Countdown.increase_time(15)
		new_round()
	else:
		$Incorrect.play()
		$Countdown.decrease_time(5)

func Verb():
	var verb = ["Harmonize", "Fluctuate", "Consolidate", "Adjust", "Focus", "Invert", "Emulsify", "Bisect"]
	return verb[randi() % verb.size()]


func TechnoBabble():
	var technoBabble = ["quantum filament", "anti-matter", "subsection cryptography", "coolant rotation", "beam emitter", "crystal resonance", "plasma flow rate", "power reciever"]
	return technoBabble[randi() % technoBabble.size()]


func _on_ControlPanel_credits():
	if creditsOpen:
		$Credits/Control.hide()
		creditsOpen = false
	else:
		$Credits/Control.show()
		creditsOpen = true
