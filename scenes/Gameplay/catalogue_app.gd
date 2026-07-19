class_name CatalogueApp extends Node2D

const CATALOGUE = preload("res://resources/GameCatalogue/catalogue.tres")
const GAME_CARD_SCENE = preload("res://scenes/GameCard/game_card.tscn")
@onready var game_container = %GameContainer

func _ready() -> void:
	
	for game in get_all_games():
		var game_card = GAME_CARD_SCENE.instantiate()
		# Fill in the game data
		game_card.get_node("VBoxContainer/AspectRatioContainer/%BoxArt").texture = game.box_art
		game_card.get_node("VBoxContainer/MarginContainer/%TitleLabel").text = game.title
		game_container.add_child(game_card)
		
func get_all_games() -> Array[GameData]:
	return CATALOGUE.games
	
func get_game() -> GameData:
	return #selected game
	
func display_game() -> void:
	pass
	
