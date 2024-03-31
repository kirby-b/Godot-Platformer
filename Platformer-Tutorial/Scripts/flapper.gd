extends CharacterBody2D
# Initial direction(right)
var direction = 1
var life = 3

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	# Detects if they hit a wall
	var found_wall = is_on_wall() 
	#Changes direction if they find a wall of ledge
	if found_wall:
		direction *= -1
	# Gets the flip with a simple boolean
	sprite.flip_h = direction > 0
	
	sprite.play("flap") # Constantly plays the walk
	velocity.x = direction * 50 # Constant speed
	move_and_slide()

func _on_weak_point_body_entered(body):
	if body is Player:
		life -= 1 #Removes a life if the body is a player
	if life <= 0:
		queue_free() #If all life is gone, it dies
