extends Node2D

onready var a = 1
onready var b = 4
onready var c = 1
onready var d = 1
var t = 0
	

func _ready():
	time_start = OS.get_unix_time()
	update()
	
func _process(delta):
	t = t + (delta * 5)
	update()

func _draw():
	# Create an Expression from the formula
	var input_names = PoolStringArray(["x"])
	var expression = Expression.new()
	var expression_format = "%s*sin(%s*x + %s) + %s*cos(%s*x + %s)"
	var formatted_expression = expression_format % [str(a), str(b), str(t), str(c), str(d), str(t)]
	var err = expression.parse(formatted_expression, input_names)
	print(str(err))
	if err != OK:
		print("Error parsing the formula: ", err)
		return

	# Choose graph dimensions and scales:
	# In pixels on screen
	var pixel_xmin = 0.0
	var pixel_xmax = 800.0
	var pixel_ymin = 50.0 # in Godot 2D, Y axis points down, but we want up
	var pixel_ymax = 0.0
	# Graph area
	var xmin = -4.0
	var xmax = 50.0
	var ymin = -4.0
	var ymax = 4.0

	var inputs = [0]
	var prev_pixel_y = null

	# For each pixel along the X axis
	for pixel_x in range(pixel_xmin, pixel_xmax):
		# Convert X to graph coordinates
		var x = lerp(xmin, xmax, inverse_lerp(pixel_xmin, pixel_xmax, pixel_x))

		# Execute expression
		inputs[0] = x
		var y = expression.execute(inputs)

		if expression.has_execute_failed() or is_inf(y) or is_nan(y):
			# Skip this point
			prev_pixel_y = null
			continue

		# Convert Y to graph coordinates
		var pixel_y = lerp(pixel_ymin, pixel_ymax, inverse_lerp(ymin, ymax, y))

		if prev_pixel_y != null:
			# Draw line if we have a previous value to connect to the current one
			draw_line(
				Vector2(pixel_x - 1, prev_pixel_y),
				Vector2(pixel_x, pixel_y),
				Color('ff9900'),
				4)

		# Remember last value so we can draw a line in the next iteration
		prev_pixel_y = pixel_y

func draw_from_puzzle( value1 ):
	b = 2* value1
	update()
