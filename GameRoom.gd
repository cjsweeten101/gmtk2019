extends Node2D

#So this will hold the deck, discard, players 
var ai_timeout = false
var player_turn = true
var ai_health = 20
var player_health = 20

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
	$AIHealth.text = "Health: " + str(ai_health)
	$PlayerHealth.text = "Health: " + str(player_health)
	if $Deck.get_children().size() == 0:
		reshuffle_discard()
	$PlayerMana.text = "Mana: " + str($PlayerHand.mana)
	attempt_to_play_cards($PlayerHand)
	attempt_to_play_cards($AIHand)

func attempt_to_play_cards(hand):
	for n in hand.get_children():
		if n.played == true:
			if hand.mana - n.mana_cost >= 0:
				resolve_card(n, hand)
	
			else:
				n.played = false

func resolve_card(card ,hand):
	#The dictionary of behaviors pls don't hurt me:
	#{"damage": int, "reshuffle": bool}
	hand.mana -= card.mana_cost
	hand.remove_child(card)
	card.position = Vector2(0,0)
	var d = card.activate()
	if d.has("damage"):
		if player_turn:
			ai_health -= d["damage"]
		else:
			player_health -= d["damage"]
	if d.has("reshuffle"):
		$Deck.add_card(card)
		$Deck.shuffle()
	else:
		$Discard.add_card(card)

func reshuffle_discard():
	for n in $Discard.get_children():
		var moving_card = n.duplicate()
		n.queue_free()
		$Deck.add_card(moving_card)
	
	$Deck.shuffle()

func _on_EndTurn_pressed():
	player_turn = false
	$PlayerHand.mana = 10
	draw(5 - $PlayerHand.get_children().size(), $PlayerHand)
	$PlayerHand.display(false)
	ai_timeout = false
	start_enemy_turn()

func start_enemy_turn():
	if $AITimer.is_stopped() and !ai_timeout:
		$PlayerHand.deactivate()
		$AITimer.start()
		ai_plays()
	else:
		pass
	
func ai_plays():
	var choice = randi()%4
	$AIHand.get_card(choice).play()
	$AIHand.get_card(choice).show()

func _on_AITimer_timeout():
	player_turn = true
	$AITimer.stop()
	ai_timeout = true
	draw(5 - $AIHand.get_children().size(), $AIHand)
	$AIHand.display(false)
	$PlayerHand.activate()
	$AIHand.mana = 10


func _on_PlayButton_pressed():
	pass # Replace with function body.
