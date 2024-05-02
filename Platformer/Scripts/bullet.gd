extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta 


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()
	queue_free()
	
func aim(direction):
	$Sprite2D.flip_h = direction > 0
	speed *= direction
	
