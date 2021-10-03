extends Node


# Declare member variables here. Examples:
export (int) var scroll_rate
var is_active
var message_rotation


# Called when the node enters the scene tree for the first time.
func _ready():
	is_active = false
	message_rotation = $Label.get_rotation()
	$Label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		$Label.rect_position.x -= scroll_rate * delta

func create_message(text):
	$Label.text = text
	is_active = true
	set_message_scroll()


func end_message():
	is_active = false


func set_message_scroll():
	$Label.rect_global_position = $EntryPoint.global_position
	$Label.show()

func _on_VisibilityNotifier2D_screen_exited():
	if is_active:
		set_message_scroll()
	else:
		$Label.hide()
