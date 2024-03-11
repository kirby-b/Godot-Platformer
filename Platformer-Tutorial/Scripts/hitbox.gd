extends Area2D

@export var instant_kill: bool = false

func _on_hitbox_body_entered(body):
	# Hurts the player
	if body is Player and instant_kill == false:
		body.player_hurt()
	elif body is Player and instant_kill == true:
		body.player_death()
