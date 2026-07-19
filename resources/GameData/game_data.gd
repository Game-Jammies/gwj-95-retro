class_name GameData extends Resource

enum MaturityRating { EVERYONE, TEEN, MATURE}
enum Genre { ADVENTURE, PLATFORMER, RPG, SHOOTER, PUZZLE, RACING, SPORTS, HORROR, FIGHTING}
enum Developer { GAPGOM, GEENOX, ID_PROGRAM, JAITO_CORPORATION, JAKEFILM_GAMES, JINTENDO, JONAMI, JONY_INTERACTIVE_ENTERTAINMENT, LORE_DESIGN, MDWEST_GAMES, MEGA, PANDAI_JAMCO, PEAK_SOFTWARE}


@export var title: String = ""
@export_multiline var description: String = ""
@export var box_art: Texture2D
@export var maturity_rating: MaturityRating = MaturityRating.EVERYONE
@export var genre: Array[Genre] = [Genre.PLATFORMER]
@export var developer: Developer = Developer.JINTENDO


func get_maturity_rating_string() -> String:
	return MaturityRating.keys()[maturity_rating].capitalize()


func get_genre_strings() -> Array[String]:
	var strings: Array[String] = []
	for g in genre:
		strings.append(Genre.keys()[g].capitalize())
	return strings


func get_developer_string() -> String:
	return Developer.keys()[developer].capitalize()
