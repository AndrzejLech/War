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
	
func draw():
	var card = cards[cards.size]
	cards.pop_back()
	return card

func getNumberOfCards():
	return cards.size()
