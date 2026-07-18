extends Node

var title: String
var icon: CompressedTexture2D
var window: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(t: String, i: CompressedTexture2D, w:PackedScene):
	#sets all values for the node, godot doesn't allow you to pass vals in innit()
	title = t
	icon = i
	window = w
	
func _on_button_pressed():
	#hides or shows window, depending on the status
	if window.visible:
		window.hide()
	else:
		window.show()
