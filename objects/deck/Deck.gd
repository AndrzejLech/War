extends Node

var  cards = []

func _ready():
	pass

func fill(newCards):
	cards = cards
	
func draw():
	var card = cards[cards.size]
	cards.pop_back()
	return card

func getNumberOfCards():
	return cards.size()
