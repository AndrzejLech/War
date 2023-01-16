extends Area2D

class_name Card

var value = 0
var card_name = ""
var suit = ""
var texture_path = ""

func _init(
		new_texture_path = "",
		new_card_name = "",
		new_value = 0,
		new_suit = ""
	):
	value = new_value
	texture_path = new_texture_path
	card_name = new_card_name
	suit = new_suit

func change(new_texture_path, new_card_name, new_value, new_suit):
	value = new_value
	texture_path = new_texture_path
	card_name = new_card_name
	suit = new_suit
	$Sprite.texture = load(new_texture_path)
	show()



func set_position(new_position):
	position = new_position

func _ready():
	hide()
