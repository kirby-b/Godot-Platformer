extends CharacterBody2D

class_name Player

@export() var moveData: Resource

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
		velocity.y = moveData.JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false
	if direction:
		velocity.x = move_toward(velocity.x,direction * moveData.SPEED, moveData.ACCELERATION)
	elif not direction and not is_on_floor():
		velocity.x = move_toward(velocity.x,direction * moveData.SPEED, moveData.ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, moveData.FRICTION)
	if is_on_floor() and direction:
		sprite.play("run")
	elif is_on_floor() and not direction:
		sprite.play("idle")
	elif not is_on_floor():
		sprite.play("jump")
	
	var was_in_air = not is_on_floor()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		sprite.play("idle")

	move_and_slide()
