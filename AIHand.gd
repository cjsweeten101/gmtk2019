extends Node2D

#Can be made true to hide hand (for ai player)
var hand_hidden = true
var mana = 10

func display(hidden):
	if hidden == false:
		for n in get_children():
			n.hide()
			n.global_position.x = 140 * n.get_index()

func get_card(n):
	for card in get_children():
		if card.get_index() == n:
			return card