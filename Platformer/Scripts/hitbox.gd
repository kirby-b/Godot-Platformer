extends Area2D

# Determines if the hitbox will instant kill you
@export var instant_kill: bool = false

# Timer for i frames
@onready var timer = $Timer

var iframes = false

func _on_hitbox_body_entered(body):
	if iframes == false:
		# Hurts the player and activates i frames
		if body is Player and instant_kill == false:
			body.lose_life()
			invincibility(body)
		elif body is Player and instant_kill == true:
			body.player_death() # Kills the player

func invincibility(body):
	# Waits for a time so the player doesnt lose all health immediately
	timer.start()
	iframes = true
	await timer.timeout
	iframes = false
