extends Node2D

export var line_color: String
var a = 2
var b = 0
var c = 4
var d = 1
var t

	

func _ready():
	update()
	
func _process(_delta):
	t = get_tree().get_root().get_node("Main").get("time")
	update()

func _draw():
	# Create an Expression from the formula
	if !t:
		return
	var input_names = PoolStringArray(["x"])
	var expression = Expression.new()
	var expression_format = "%s*sin(%s*x + %s) + %s*cos(%s*x + %s)"
	var formatted_expression = expression_format % [str(a), str(b), str(t), str(c), str(d), str(t)]
	var err = expression.parse(formatted_expression, input_names)
	if err != OK:
		print("Error parsing the formula: ", err)
		return

	# Choose graph dimensions and scales:
	# In pixels on screen
	var pixel_xmin = 0.0
	var pixel_xmax = 600.0
	var pixel_ymin = 75.0 # in Godot 2D, Y axis points down, but we want up
	var pixel_ymax = 5.0
	# Graph area
	var xmin = -4.5
	var xmax = 20.0
	var ymin = -4.5
	var ymax = 4.5

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
				Color(line_color),
				4)

		# Remember last value so we can draw a line in the next iteration
		prev_pixel_y = pixel_y

func draw_from_puzzle( value1, value2, value3, value4, value5 ):
	if value5 == 0:
		value5 = -1
	b = 2* value1
	c = value2 * value5
	a = value3 
	d = 2 * value4
	update()
