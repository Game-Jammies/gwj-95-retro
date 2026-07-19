class_name Computer extends Control

@export var window_load: PackedScene
@export var spawn_pos: Vector2

func _ready() -> void:
	#spawn the tutorial window
	var window = window_load.instantiate()
	window.global_position = spawn_pos
	get_tree().root.add_child.call_deferred(window)
