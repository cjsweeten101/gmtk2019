extends Node2D
export var hidden = true

export var default_size = 20
var fireball_resource = preload("res://Fireball.tscn")
var knight_resource = preload("res://Knight.tscn")
var default_resource = preload("res://Card.tscn")
var rewind_resource = preload("res://Rewind.tscn")
var wipe_resource = preload("res://Wipe.tscn")
var cards_in_deck = []

func _ready():
	for i in range(0,default_size):
		var new_card
		if i <= 5:
			new_card = fireball_resource.instance()
		elif i <= 10:
			new_card = rewind_resource.instance()
		elif i <= 15:
			new_card = wipe_resource.instance()
		elif i<=20:
			new_card = knight_resource.instance()
		new_card.hide()
		add_child(new_card)
		cards_in_deck.append(new_card)
	shuffle()

func _physics_process(delta):
	if hidden:
		for n in get_children():
			n.hide()
	else:
		for n in get_children():
			n.show()

func get_card():
	var card = cards_in_deck[0]
	cards_in_deck.pop_front()
	remove_child(card)
	return card

func count_children():
	return get_children().size()

func shuffle():
	cards_in_deck.shuffle()

func add_card(card, booly):
	add_child(card)
	if booly:
		card.hide()
	else:
		card.show()
	cards_in_deck.append(card)