extends Control
@export var window_load: PackedScene
@export var spawn_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func spawn_object():
	#spawn the window
	var window = window_load.instantiate()
	window.global_position = spawn_pos
	get_tree().root.add_child(window)
