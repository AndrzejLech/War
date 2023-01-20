extends Node

func compare_third_card(
	enemy_card_value: int,
	player_card_value: int,
	points_value: Array
	) -> Dictionary:
	var score_at_stake = 0
	for element in points_value:
		score_at_stake += element
	score_at_stake += player_card_value + enemy_card_value
	
	if enemy_card_value > player_card_value:
		return {"enemy_won":true, "score": score_at_stake}
	elif enemy_card_value < player_card_value:
		return {"enemy_won":false, "score":score_at_stake}
	else:
		return {"enemy_won": false, "score": 0}

func compare_card(
	player_card_value: int,
	enemy_card_value: int
) -> Dictionary:
	var score_at_stake = player_card_value + enemy_card_value
	
	if enemy_card_value > player_card_value:
		return {"is_war": false, "enemy_won": true, "score": score_at_stake}
	elif enemy_card_value < player_card_value:
		return {"is_war": false, "enemy_won": false, "score": score_at_stake}
	else:
		return {"is_war": true, "enemy_won": true, "score": 0}
