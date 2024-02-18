extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.queue_free()
		get_tree().reload_current_scene()
