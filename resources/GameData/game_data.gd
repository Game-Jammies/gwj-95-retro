class_name GameData extends Resource

enum MaturityRating { EVERYONE, TEEN, MATURE}
enum Genre { PLATFORMER, RPG, SHOOTER, PUZZLE, RACING, SPORTS, HORROR}
enum System { JINTENDO_ENTERTAINMENT_SYSTEM, JONAMI}


@export var title: String = ""
@export_multiline var description: String = ""
@export var box_art: Texture2D
@export var maturity_rating: MaturityRating = MaturityRating.EVERYONE
@export var genre: Genre = Genre.PLATFORMER
@export var system: System = System.JINTENDO_ENTERTAINMENT_SYSTEM
