extends Node

var database = preload("res://data/CardsDatabase.gd")

func _ready():
	var CardArray = shuffleArray(loadDatabase())
	var first_half = CardArray.slice(0, ( CardArray.size() / 2))
	var second_half = CardArray.slice((CardArray.size() / 2) + 1, CardArray.size())
	print(first_half)
	print(second_half)

func loadDatabase() -> Array:
	var array: Array = []
	for element in database.CardsInfo:
		array.append(element)
	return array
	
func shuffleArray(array: Array) -> Array:
	randomize()
	array.shuffle()
	return array
	
