extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta 

# Breaks upon entering a body and removes an enemy life on contact
func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.lose_life()
	queue_free()
	
# Makes the bullet face and fire the right way
func aim(direction):
	$Sprite2D.flip_h = direction > 0
	speed *= direction
	
