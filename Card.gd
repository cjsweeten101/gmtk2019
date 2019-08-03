extends Node2D

var played = false
export var mana_cost = 5
var hidden = false

#This may be a bit more complicated for monster cards
func play():
	played = true

func _on_TextureButton_pressed():
	play()

func hide():
	$CardBack.visible = true

func show():
	$CardBack.visible = false

func activate():
	pass

func enable():
	$TextureButton.disabled = false

func disable():
	$TextureButton.disabled = true