class_name GameCard extends Control

signal pressed(game_data: GameData)

var game_data: GameData

## Sets the box art and title for the game card display.
func set_game_data(data: GameData) -> void:
	game_data = data
	%BoxArt.texture = data.box_art
	%TitleLabel.text = data.title


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			pressed.emit(game_data)
			print(game_data)
