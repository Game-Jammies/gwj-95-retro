extends Control
@export var window_load: PackedScene
@export var spawn_pos: Vector2

func spawn_object():
	#spawn the window
	var window = window_load.instantiate()
	window.global_position = spawn_pos
	get_tree().root.add_child(window)
