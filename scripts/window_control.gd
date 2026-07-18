extends Node

func _on_close_pressed():
	#destroy itself when closed
	print("Close button pressed")
	"""TODO: maybe make some sort of small animation when close? not necessessary"""
	get_parent().remove_child(self)
	self.queue_free()
