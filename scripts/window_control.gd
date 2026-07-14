extends Node
class_name WindowControl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_pressed():
	#destroy itself when closed
	print("Close button pressed")
	"""TODO: maybe make some sort of small animation when close? not necessessary"""
	queue_free()
