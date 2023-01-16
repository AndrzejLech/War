extends Area2D

var  cards = []

func _ready():
	pass

func fill(array: Array, newPosition):
	for element in array:
		cards.append(
			Card.new(
				element[0],
				element[2],
				element[3],
				element[1]
			)
		)
		position = newPosition
	
func draw() -> Card:
	var card = cards[cards.size() - 1]
	cards.pop_back()
	return card

func get_number_of_cards():
	return cards.size()
