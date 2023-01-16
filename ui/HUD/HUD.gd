extends CanvasLayer

signal draw_button_pressed
signal new_game_button_pressed

var enemy_score = 0
var player_score = 0

func _ready():
	$NewGameButton.hide()
	pass

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func set_enemy_score(score):
	enemy_score = score

func get_enemy_score():
	return enemy_score

func set_player_score(score):
	player_score = score

func get_player_score():
	return player_score


func _on_DrawButton_pressed():
	emit_signal("draw_button_pressed")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_NewGameButton_pressed():
	emit_signal("new_game_button_pressed")
