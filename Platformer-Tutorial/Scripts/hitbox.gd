extends Area2D

@export var instant_kill: bool = false

@onready var timer = $Timer

var iframes = false

func _on_hitbox_body_entered(body):
	if iframes == false:
		# Hurts the player
		if body is Player and instant_kill == false:
			body.player_hurt()
			invincibility(body)
		elif body is Player and instant_kill == true:
			body.player_death()

func invincibility(body):
	timer.start()
	iframes = true
	await timer.timeout
	iframes = false
