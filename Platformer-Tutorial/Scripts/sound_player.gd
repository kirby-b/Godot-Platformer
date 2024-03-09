extends Node

const BOOM = preload("res://Sounds/boom.wav")
const COIN = preload("res://Sounds/coin.wav")
const HURT = preload("res://Sounds/hurt.wav")
const JUMP = preload("res://Sounds/Jump.wav")
const LOSE = preload("res://Sounds/lose.wav")
const ONEUP = preload("res://Sounds/one_up.wav")
const ZAP = preload("res://Sounds/zap.wav")	

@onready var sounds = $Players

func play_sound(sound):
	for x in sounds.get_children():
		if not x.playing:
			x.stream = sound
			x.play()
			break
