class_name CatalogueApp extends Control

const CATALOGUE = preload("res://resources/GameCatalogue/catalogue.tres")
const GAME_CARD_SCENE = preload("res://scenes/GameCard/game_card.tscn")
# Main container and panel for displaying catalogue and a specific game's data
@onready var catalogue_container = %CatalogueContainer
@onready var game_panel = %GamePanel
# Nested within the catalogue, game cards are added to this container
@onready var game_container = %GameContainer
# Genre filter buttons are populated at runtime; clicking one filters the game cards
@onready var genre_filter_container = %GenreFilterContainer


func _ready() -> void:
	catalogue_container.show()
	game_panel.hide()

	for game in get_all_games():
		var game_card = GAME_CARD_SCENE.instantiate()
		game_card.set_game_data(game)
		game_card.pressed.connect(_on_game_card_pressed)
		game_container.add_child(game_card)

	_populate_genre_filters()

func _on_game_card_pressed(game_data: GameData) -> void:
	_display_game(game_data)


## Adds an "All" button plus one button per GameData.Genre value to the genre filter container
func _populate_genre_filters() -> void:
	var all_button = LinkButton.new()
	all_button.text = "All"
	all_button.pressed.connect(_on_genre_filter_pressed.bind(-1))
	all_button.theme_type_variation = "FilterLink"
	genre_filter_container.add_child(all_button)

	for genre in GameData.Genre.keys():
		var genre_id = GameData.Genre.get(genre);
		
		var genre_button = LinkButton.new()
		genre_button.text = genre.capitalize()
		genre_button.pressed.connect(_on_genre_filter_pressed.bind(genre_id))
		genre_button.theme_type_variation = "FilterLink"
		
		genre_filter_container.add_child(genre_button)


## Shows only the game cards matching the given genre, or all cards if genre_id is -1
func _on_genre_filter_pressed(genre_id: int) -> void:
	for game_card in game_container.get_children():
		game_card.visible = genre_id == -1 or genre_id in game_card.game_data.genre

func get_all_games() -> Array[GameData]:
	var sorted_games = CATALOGUE.games.duplicate()
	sorted_games.sort_custom(func(a, b): return a.title < b.title)
	return sorted_games


## Displays the given game data inside the game panel in the catalogue app
func _display_game(game_data: GameData) -> void:
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
func _show_catalogue() -> void:
	game_panel.hide()
	catalogue_container.show()
	pass


func _on_back_button_pressed() -> void:
	_show_catalogue()
