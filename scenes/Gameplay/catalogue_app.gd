class_name CatalogueApp extends Node2D

const CATALOGUE = preload("res://resources/GameCatalogue/catalogue.tres")
const GAME_CARD_SCENE = preload("res://scenes/GameCard/game_card.tscn")
# Main container and panel for displaying catalogue and a specific game's data
@onready var catalogue_container = %CatalogueContainer
@onready var game_panel = %GamePanel
# Nested within the catalogue, game cards are added to this container
@onready var game_container = %GameContainer


func _ready() -> void:
	catalogue_container.show()
	game_panel.hide()
	
	for game in get_all_games():
		var game_card = GAME_CARD_SCENE.instantiate()
		game_card.set_game_data(game)
		game_card.pressed.connect(_on_game_card_pressed)
		game_container.add_child(game_card)

func _on_game_card_pressed(game_data: GameData) -> void:
	display_game(game_data)

func get_all_games() -> Array[GameData]:
	return CATALOGUE.games


## Displays the given game data inside the game panel in the catalogue app
func display_game(game_data: GameData) -> void:
	catalogue_container.hide()
	
	# Load game card data
	game_panel.get_node("%Title").text = game_data.title
	game_panel.get_node("%Genre").text = ", ".join(game_data.get_genre_strings())
	game_panel.get_node("%Developer").text = game_data.get_developer_string()
	game_panel.get_node("%MaturityRating").text = game_data.get_maturity_rating_string()
	game_panel.get_node("%Description").text = game_data.description
	game_panel.get_node("%BoxArt").texture = game_data.box_art
	
	game_panel.show()


## Displays the game catalogue
func show_catalogue() -> void:
	game_panel.hide()
	catalogue_container.show()
	pass
