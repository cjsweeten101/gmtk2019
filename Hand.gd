extends Node2D

#Can be made true to hide hand (for ai player)
var hand_hidden = false
var mana = 10

func display(viewable):
	#Iterates through cards and spaces them appropriately:
	for n in get_children():
		n.show()
		n.global_position.x = 140 * n.get_index()
func deactivate():
	for n in get_children():
		n.disable()

func activate():
	for n in get_children():
		n.enable()