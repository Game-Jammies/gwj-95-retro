extends Node
class_name WindowControl

@export var min_size: Vector2 #the minimum size the window is allowed to have
@onready var panel = $Panel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_pressed():
	#destroy itself when closed
	print("Close button pressed")
	get_parent().remove_child(self)
	self.queue_free()
