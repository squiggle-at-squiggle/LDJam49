extends Node

# Declare member variables here. Examples:
var solution
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	solution = randi() % 4 # random int between 0 and 3
	print(solution)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
