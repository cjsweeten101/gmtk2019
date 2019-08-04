extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cards_in_field = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func add_card(card):
	add_child(card)
	card.show()
	cards_in_field.append(card)
	display()

func display():
	#Iterates through cards and spaces them appropriately:
	for n in get_children():
		n.global_position.x = 140 * n.get_index()

