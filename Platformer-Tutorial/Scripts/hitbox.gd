extends Area2D

func _on_hitbox_body_entered(body):
	# Resets when you touch a enemy other bad thing
	if body is Player:
		body.player_hurt()
