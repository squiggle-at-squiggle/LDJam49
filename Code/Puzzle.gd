extends Node


# Declare member variables here. Examples:
var solution
var solution2
var solution3
var solution4
var solution5
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#solution = randi() % 4 # random int between 0 and 3


func generate_puzzle(slider_min, slider_max):
	solution = randi() % int(slider_max)  + slider_min
	solution2 = randi() % int(slider_max)  + slider_min
	solution3 = randi() % int(slider_max)  + slider_min
	solution4 = randi() % int(slider_max)  + slider_min
	var truthy = [1,-1]
	solution5 = truthy[randi() % 2]
	$EngineGraph.draw_from_puzzle(solution,solution2,solution3,solution4,solution5)
	$Solution.text = str(solution, solution2, solution3, solution4, solution5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
