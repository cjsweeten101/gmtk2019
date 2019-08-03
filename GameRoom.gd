extends Node2D

#So this will hold the deck, discard, players 

var turn_bool

func _ready():
	draw(5,$PlayerHand)
	$PlayerHand.display(true)
	draw(5, $AIHand)
	$AIHand.display(false)

func draw(numb_cards, new_owner):
	for i in range(0,numb_cards):
		if $Deck.get_children().size() >= 1:
			var target = $Deck.get_card().duplicate()
			var source = new_owner
			source.add_child(target)

func _physics_process(delta):
	if $Deck.get_children().size() == 0:
		reshuffle_discard()
	$PlayerMana.text = "Mana: " + str($PlayerHand.mana)
	redraw_hand($PlayerHand)
	#start_enemy_turn()

func redraw_hand(hand):
	for n in hand.get_children():
		if n.played == true:
			if hand.mana - n.mana_cost >= 0:
				n.activate()
				hand.mana -= n.mana_cost
				hand.remove_child(n)
				n.position = Vector2(0,0)
				$Discard.add_child(n)
			else:
				n.played = false

func reshuffle_discard():
	for n in $Discard.get_children():
		var moving_card = n.duplicate()
		n.queue_free()
		$Deck.add_card(moving_card)
	
	$Deck.shuffle()

func _on_EndTurn_pressed():
	#Reset mana, draw cards, Enemy turn
	$PlayerHand.mana = 10
	draw(5 - $PlayerHand.get_children().size(), $PlayerHand)
	$PlayerHand.display(false)
	start_enemy_turn()

func start_enemy_turn():
	pass
