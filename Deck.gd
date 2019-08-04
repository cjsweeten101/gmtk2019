extends Node2D

export var default_size = 20
var temp_card_resource = preload("res://Fireball.tscn")
var cards_in_deck = []

func _ready():
	for i in range(0,default_size):
		var new_card = temp_card_resource.instance()
		new_card.hide()
		add_child(new_card)
		cards_in_deck.append(new_card)

func get_card():
	var card = cards_in_deck[0]
	cards_in_deck.pop_front()
	remove_child(card)
	return card

func count_children():
	return get_children().size()

func shuffle():
	cards_in_deck.shuffle()

func add_card(card):
	add_child(card)
	card.hide()
	cards_in_deck.append(card)