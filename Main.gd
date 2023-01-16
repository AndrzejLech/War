extends Node

var is_war = false
var is_second_cards_on = false
var database = preload("res://data/CardsDatabase.gd")

func _ready():

	$HUD/DrawButton.disabled = false
	$HUD/NewGameButton.hide()
	hide_additional_cards()
	
	var card_array = shuffle_array(load_database())
	var first_half = card_array.slice(0, 25)
	var second_half = card_array.slice(26, 51)
	
	$EnemyDeck.fill(first_half, $EnemyDeckPosition.position)
	$PlayerDeck.fill(second_half, $PlayerDeckPosition.position)
	$PlayerCard.set_position($PlayerCardPosition.position)
	$EnemyCard.set_position($EnemyCardPosition.position)
	
	$HUD.set_enemy_score(0)
	$HUD.set_player_score(0)

func load_database() -> Array:
	var array: Array = []
	for element in database.CardsInfo.values():
		array.append(element)
	return array


func shuffle_array(array: Array) -> Array:
	randomize()
	array.shuffle()
	return array
	


func end_game():
	$HUD.show_message(compare_score() + " wins the game!")
	yield($HUD/MessageTimer, "timeout")
	$HUD/DrawButton.disabled = true
	$HUD/NewGameButton.show()
	


func compare_score():
	var winner = ""
	if $HUD.get_enemy_score() < $HUD.get_player_score():
		winner = "Player"
	else:
		winner = "Enemy"
	return winner


func _on_PlayerDeck_mouse_entered():
	$HUD/InfoLabel.text = 	"You have " + str($PlayerDeck.get_number_of_cards()) + " cards left."
	print("_on_PlayerDeck_mouse_entered")


func _on_PlayerDeck_mouse_exited():
	$HUD/InfoLabel.text = ""
	print("_on_PlayerDeck_mouse_exited")


func _on_EnemyDeck_mouse_entered():
	$HUD/InfoLabel.text = 	"Enemy has " + str($EnemyDeck.get_number_of_cards()) + " cards left."


func _on_EnemyDeck_mouse_exited():
	$HUD/InfoLabel.text = ""


func _on_HUD_draw_button_pressed():
	if($PlayerDeck.cards.size() == 0):
		end_game()
		return
	
	var new_player_card = $PlayerDeck.draw()
	var new_enemy_card = $EnemyDeck.draw()
	
	if !is_war:
		$PlayerCard.change(new_player_card.texture_path, new_player_card.card_name,new_player_card.value, new_player_card.suit)
		$EnemyCard.change(new_enemy_card.texture_path, new_enemy_card.card_name, new_enemy_card.value, new_enemy_card.suit)
	else:
		if is_second_cards_on:
			$EnemyThirdCard.change(new_enemy_card.texture_path, new_enemy_card.card_name, new_enemy_card.value, new_enemy_card.suit)
			$EnemySecondCard.reverse_card()
			
			$PlayerThirdCard.change(new_player_card.texture_path, new_player_card.card_name, new_player_card.value, new_player_card.suit)
			$PlayerSecondCard.reverse_card()
			is_war = false
		else:
			$EnemySecondCard.hide()
			$EnemySecondCard.change(new_enemy_card.texture_path, new_enemy_card.card_name, new_enemy_card.value, new_enemy_card.suit)
			$EnemySecondCard.reverse_card()
			$EnemySecondCard.show()
			
			$PlayerSecondCard.hide()
			$PlayerSecondCard.change(new_player_card.texture_path, new_player_card.card_name, new_player_card.value,new_player_card.suit)
			$PlayerSecondCard.reverse_card()
			$PlayerSecondCard.show()
			
			is_second_cards_on = true
			
	compare_cards()


func compare_cards():
	# checking third card
	if !is_war and is_second_cards_on:
		if $EnemyThirdCard.value > $PlayerThirdCard.value:
			$HUD.set_enemy_score(
				$HUD.get_enemy_score() +
				int($EnemyCard.value) +
				int($EnemySecondCard.value) +
				int($EnemySecondCard.value) +
				int($PlayerCard.value) +
				int($PlayerSecondCard.value) +
				int($PlayerThirdCard.value) 
				)
			$HUD/EnemyScoreLabel.text = "Enemy \n Score: " + str($HUD.get_enemy_score())
			$HUD.show_message("Enemy won the WAR!")
			
			print("Enemy won War "+ $EnemyThirdCard.value + " vs " + $PlayerThirdCard.value)
			
		if $EnemyThirdCard.value < $PlayerThirdCard.value:
			$HUD.set_player_score(
				$HUD.get_player_score() +
				int($EnemyCard.value) +
				int($EnemySecondCard.value) +
				int($EnemySecondCard.value) +
				int($PlayerCard.value) +
				int($PlayerSecondCard.value) +
				int($PlayerThirdCard.value) 
			)
			$HUD/EnemyScoreLabel.text = "Your \n Score: " + str($HUD.get_player_score())
			$HUD.show_message("You won the WAR!")
			
			print("Player won War "+ $PlayerThirdCard.value + " vs " + $EnemyThirdCard.value)
			
		is_second_cards_on = false
		
	#no war checking	
	elif !is_war and !is_second_cards_on:
		hide_additional_cards()
		
		if $EnemyCard.value > $PlayerCard.value:
			$HUD.set_enemy_score($HUD.get_enemy_score() + int($EnemyCard.value) + int($PlayerCard.value))
			$HUD/EnemyScoreLabel.text = "Enemy \n Score: " + str($HUD.get_enemy_score())
			$HUD.show_message("Enemy Wins!")
			
			print("Enemy won "+ $EnemyCard.value + " vs " + $PlayerCard.value)
			
		elif $EnemyCard.value < $PlayerCard.value:
			$HUD.set_player_score($HUD.get_player_score() + int($EnemyCard.value) + int($PlayerCard.value))
			$HUD/PlayerScoreLabel.text = "Your \n Score: " + str($HUD.get_player_score())
			$HUD.show_message("You Win!")
			print("Player won "+ $PlayerCard.value + " vs " + $EnemyCard.value)
		else:
			$HUD.show_message("War!")
			is_war = true

func hide_additional_cards():
	$PlayerSecondCard.hide()
	$PlayerThirdCard.hide()
	$EnemySecondCard.hide()
	$EnemyThirdCard.hide()


func _on_HUD_new_game_button_pressed():
	_ready()
	
	
func _on_EnemyCard_card_info(card_name, card_suit, card_value):
	if card_name != "":
		$HUD/InfoLabel.text = "Card: " + card_name + "\n" + "Suit: " + card_suit + "\n" + "Value: " + card_value
	else:
		$HUD/InfoLabel.text = ""


func _on_EnemySecondCard_card_info(card_name, card_suit, card_value):
	if card_name != "" and 	$EnemySecondCard.is_shown:
		$HUD/InfoLabel.text = "Card: " + card_name + "\n" + "Suit: " + card_suit + "\n" + "Value: " + card_value
	else:
		$HUD/InfoLabel.text = ""


func _on_EnemyThirdCard_card_info(card_name, card_suit, card_value):
	if card_name != "":
		$HUD/InfoLabel.text = "Card: " + card_name + "\n" + "Suit: " + card_suit + "\n" + "Value: " + card_value
	else:
		$HUD/InfoLabel.text = ""


func _on_PlayerCard_card_info(card_name, card_suit, card_value):
	if card_name != "":
		$HUD/InfoLabel.text = "Card: " + card_name + "\n" + "Suit: " + card_suit + "\n" + "Value: " + card_value
	else:
		$HUD/InfoLabel.text = ""


func _on_PlayerSecondCard_card_info(card_name, card_suit, card_value):
	if card_name != "" and 	$PlayerSecondCard.is_shown:
		$HUD/InfoLabel.text = "Card: " + card_name + "\n" + "Suit: " + card_suit + "\n" + "Value: " + card_value
	else:
		$HUD/InfoLabel.text = ""


func _on_PlayerThirdCard_card_info(card_name, card_suit, card_value):
	if card_name != "":
		$HUD/InfoLabel.text = "Card: " + card_name + "\n" + "Suit: " + card_suit + "\n" + "Value: " + card_value
	else:
		$HUD/InfoLabel.text = ""

