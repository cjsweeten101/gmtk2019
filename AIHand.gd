extends Node2D

#Can be made true to hide hand (for ai player)
var hand_hidden = true
var mana = 10

func display(hidden):
	#Iterates through cards and spaces them appropriately:
	for n in get_children():
		n.hide()
		n.global_position.x = 140 * n.get_index()
