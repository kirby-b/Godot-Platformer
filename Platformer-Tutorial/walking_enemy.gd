extends CharacterBody2D

var direction = 1

@onready var ledgecheckR = $LedgeCheckerR
@onready var ledgecheckL = $LedgeCheckerL
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	
	var found_wall = is_on_wall()
	var found_ledge = not ledgecheckR.is_colliding() or not ledgecheckL.is_colliding()
	
	if found_wall or found_ledge:
		direction *= -1
	
	sprite.flip_h = direction > 0
	
	sprite.play("walk")
	velocity.x = direction * 25
	move_and_slide()
	
