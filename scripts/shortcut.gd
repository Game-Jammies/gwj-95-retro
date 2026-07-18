extends Control
@export var window_load: PackedScene
@export var spawn_pos: Vector2
var window

func spawn_object():
	#spawn the window
	window = window_load.instantiate()
	window.global_position = spawn_pos
	get_tree().root.add_child(window)

func _on_shortcut_pressed():
	if !is_instance_valid(window):
		#if window doesn't exist, spawn it
		spawn_object()
	else:
	#hide or show the window, depending on what it is
		if window.visible:
			window.hide()
		else:
			window.show()
