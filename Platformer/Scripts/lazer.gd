extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta 

# Breaks upon entering a body and removes an enemy life on contact
func _on_body_entered(body):
	if body.is_in_group("characters"):
		body.lose_life()
	queue_free()
	
# Makes the bullet face and fire the right way
func aim(direction):
	$Sprite2D.flip_h = direction > 0
	speed *= direction
	
# Removes the bullet when it leaves the screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
