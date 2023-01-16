extends Area2D

class_name Card

signal card_info(card_name,card_suit,card_value)

var value = 0
var card_name = ""
var suit = ""
var texture_path = ""
var is_shown = true
var hidden_card_textrure_path = "res://assets/cards/card_back.png"

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

func reverse_card():
	if !is_shown:
		$Sprite.texture = load(texture_path)
	else:
		$Sprite.texture = load(hidden_card_textrure_path)
	is_shown = !is_shown

func set_position(new_position):
	position = new_position

func _ready():
	hide()


func _on_Card_mouse_entered():
	emit_signal("card_info", card_name, suit, value)

func _on_Card_mouse_exited():
	emit_signal("card_info", "", "", "")
