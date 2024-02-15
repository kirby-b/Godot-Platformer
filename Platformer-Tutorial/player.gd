extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -220.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $AnimatedSprite2D

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false
	if direction:
		velocity.x = move_toward(velocity.x,direction * SPEED, 10)
	elif not direction and not is_on_floor():
		velocity.x = move_toward(velocity.x,direction * SPEED, 10)
	else:
		velocity.x = move_toward(velocity.x, 0, 20)
	if is_on_floor() and direction:
		sprite.play("run")
	elif is_on_floor() and not direction:
		sprite.play("idle")
	elif not is_on_floor():
		sprite.play("jump")

	move_and_slide()
