extends Area2D

func _ready():
	hide()

func initiate(newPosition, texturePath, cardName, value):
	position = newPosition
	value = value
	Texture.load(texturePath)
	cardName = cardName
	show()
