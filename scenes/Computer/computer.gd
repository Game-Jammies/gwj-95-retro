class_name Computer extends Control

@export var tutorial_scene: PackedScene

func _ready() -> void:
	var tutorial: Control = tutorial_scene.instantiate()
	
	# center the tutorial window
	tutorial.global_position = (get_viewport_rect().size - tutorial.size) / 2 
	
	get_tree().root.add_child.call_deferred(tutorial)
