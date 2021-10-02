extends Node

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var solution = randi() % 4 # random int between 0 and 3
	$Solution.text = str(solution)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
