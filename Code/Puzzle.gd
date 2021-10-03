extends Node



# Declare member variables here. Examples:
var solution
var solution2
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#solution = randi() % 4 # random int between 0 and 3
	

func generate_puzzle(slider_min, slider_max):
	solution = randi() % (int(slider_max) + 1) + int(slider_min)
	solution2 = randi() % (int(slider_max) + 1) + int(slider_min)
	$EngineGraph.draw_from_puzzle(solution,solution2)
	$Solution.text = str(solution)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
