extends Area2D

class_name Card

var value
var card_name
var suit
var texture_path

func _init(new_texture_path, new_card_name, value, suit):
	value = value
	texture_path = new_texture_path
	card_name = new_card_name
	suit = suit
	

func _ready():
	$Sprite.texture.load(texture_path)
	hide()

func showCard():
	show()
