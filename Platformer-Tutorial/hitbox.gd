extends Area2D

func _on_hitbox_body_entered(body):
	if body is Player:
		get_tree().call_deferred("reload_current_scene")
