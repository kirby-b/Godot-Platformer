extends CharacterBody2D

# Initial direction(right)
var direction = 1
@export() var speed: float


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Gets needed node variables
@onready var ledgecheckR = $LedgeCheckerR
@onready var ledgecheckL = $LedgeCheckerL
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Adds the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Detects if they hit a wall
	var found_wall = is_on_wall() 
	# Checks if they are at a ledge
	var found_ledge = not ledgecheckR.is_colliding() or not ledgecheckL.is_colliding()
	
	#Changes direction if they find a wall of ledge
	if found_wall or found_ledge:
		direction *= -1
	# Gets the flip with a simple boolean
	sprite.flip_h = direction > 0
	
	sprite.play("walk") # Constantly plays the walk
	velocity.x = direction * speed # Constant speed
	move_and_slide()
