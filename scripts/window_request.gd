extends Node
"""Handles the requests for windows"""

const CATALOGUE = preload("res://resources/GameCatalogue/catalogue.tres")

@export var file_path : String #eg res://text/file.txt
var game_desc: Array = []
var target_game_title: String #the target game
@onready var dropdown = %OptionButton

const CORRECT_MSG: String = "This is exactly what I wanted! Thank you!"
const INCORRECT_MSG: String = "No, I don't think this is what I'm looking for."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Feedback.visible = false
	if file_path == "":
		print("You didn't set the file path!")
	else:
		load_file()
		load_random_game()
	populate_dropdown()


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
		game_desc.erase("") #handle blank lines
	else:
		print("File doesn't exist, did you enter the right path?")
		
func load_random_game():
	var target = game_desc.pick_random().split("%")
	target_game_title = target[0].strip_edges()
	%ContentText.text = target[1].strip_edges()

func populate_dropdown():
	"""Populates the OptionButton to include"""
	"""TODO: access the gamecatalogue from game_catalogue.gd"""
	#remove the dummy options when we do the TODO above
	dropdown.clear()
	dropdown.add_item("SELECT GAME", 0)

	for game in CATALOGUE.games:
		dropdown.add_item(game.title)
	
	dropdown.selected = 0
	
func _on_submit_button_clicked():
	#TODO: emit a signal from the dropdown.get_selected_id()
	print(target_game_title)
	if dropdown.get_selected_id() > 0:
		%LowerBounds.visible = false
		var selected_game = dropdown.get_item_text(dropdown.selected)
		print(selected_game)
		if selected_game.to_upper() == target_game_title.to_upper():
			%ResponseText.text = CORRECT_MSG
		else:
			%ResponseText.text = INCORRECT_MSG
		%TitleLabel.text = "Emails: Response from Customer"
		%Feedback.visible = true

func _on_response_button_pressed():
	%Feedback.visible = false
	load_random_game()
	%TitleLabel.text = "Emails: Game Requested!"
	%LowerBounds.visible = true
