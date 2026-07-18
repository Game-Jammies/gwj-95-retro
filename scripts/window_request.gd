extends Node

@export var file_path : String #eg res://text/file.txt
var game_desc: Array = []
var target_game_title: String #the target game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_file()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_file():
	"""Loads each item as an array"""
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		game_desc = content.split("\n")
	else:
		print("File doesn't exist, did you enter the right path?")
		
