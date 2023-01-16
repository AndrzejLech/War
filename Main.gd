extends Node

var database = preload("res://data/CardsDatabase.gd")

func _ready():
	var CardArray = shuffleArray(loadDatabase())
	var first_half = CardArray.slice(0, (CardArray.size() / 2))
	var second_half = CardArray.slice((CardArray.size() / 2) + 1, CardArray.size())
	$EnemyDeck.fill(first_half, $EnemyDeckPosition.position)
	$PlayerDeck.fill(second_half, $PlayerDeckPosition.position)

func loadDatabase() -> Array:
	var array: Array = []
	for element in database.CardsInfo.values():
		array.append(element)
	return array
	
func shuffleArray(array: Array) -> Array:
	randomize()
	array.shuffle()
	return array
	
