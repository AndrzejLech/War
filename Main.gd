extends Node

var database = preload("res://data/CardsDatabase.gd")
var enemy_score = 0
var player_score = 0

func _ready():
	enemy_score = 0
	player_score = 0
	var card_array = shuffle_array(load_database())
	var first_half = card_array.slice(0, 25)
	var second_half = card_array.slice(26, 51)
	
	print(compare_arrays(first_half, second_half))
	
	$EnemyDeck.fill(first_half, $EnemyDeckPosition.position)
	$PlayerDeck.fill(second_half, $PlayerDeckPosition.position)
	$PlayerCard.set_position($PlayerCardPosition.position)
	$EnemyCard.set_position($EnemyCardPosition.position)


func load_database() -> Array:
	var array: Array = []
	for element in database.CardsInfo.values():
		array.append(element)
	return array


func shuffle_array(array: Array) -> Array:
	randomize()
	array.shuffle()
	return array


func _on_PlayerDeck_mouse_entered():
	$InfoLabel.text = 	"You have " + str($PlayerDeck.get_number_of_cards()) + " cards left."


func _on_PlayerDeck_mouse_exited():
	$InfoLabel.text = ""


func _on_EnemyDeck_mouse_entered():
	$InfoLabel.text = 	"Enemy has " + str($EnemyDeck.get_number_of_cards()) + " cards left."


func _on_EnemyDeck_mouse_exited():
	$InfoLabel.text = ""


func _on_Button_pressed():
	var new_player_card = $PlayerDeck.draw()
	var new_enemy_card = $EnemyDeck.draw()
	
	$PlayerCard.change(
		new_player_card.texture_path,
		new_player_card.card_name,
		new_player_card.value,
		new_player_card.suit
	)
	
	$EnemyCard.change(
		new_enemy_card.texture_path,
		new_enemy_card.card_name,
		new_enemy_card.value,
		new_enemy_card.suit
	)
	
	compare_cards()
	
	if $PlayerDeck.cards.size()== 0:
		_ready()


func compare_cards():
	if $EnemyCard.value > $PlayerCard.value:
		enemy_score += int($EnemyCard.value) + int($PlayerCard.value)
		$EnemyScoreLabel.text = "Enemy \n Score: " + str(enemy_score)
	else:
		player_score += int($EnemyCard.value) + int($PlayerCard.value)
		$PlayerScoreLabel.text = "Your \n Score: " + str(player_score)


func compare_arrays(array1, array2):
	var has_same_element = false
	
	for element1 in array1:
		for element2 in array2:
			if element1 == element2:
				has_same_element = true
	
	return has_same_element
