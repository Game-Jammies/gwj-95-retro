class_name WindowInfo extends Resource

@export var title: String
@export var icon: CompressedTexture2D
@export var window: PackedScene

func set_window(win:PackedScene):
	#manually set the loaded window
	window = win
