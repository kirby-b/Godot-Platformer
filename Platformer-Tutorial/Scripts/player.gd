extends CharacterBody2D
class_name Player

# States for whether you are climbing or on the ground
enum{
	MOVE,
	CLIMB
}

# Gets movement data variables
@export() var moveData: Resource

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Initial Variables
var state = MOVE
var double_jump = 0 
var was_in_air = false # Tracks whether the player was just in the air
var jump_buffer = false # Tranks whether the jump buffer is on
var life = 6

# On ready variables to access nodes 
@onready var sprite = $AnimatedSprite2D
@onready var ladder_check = $LadderChecker
@onready var jump_timer = $JumpBuffer
@onready var remote_trans = $RemoteTransform2D

func _ready():
	double_jump = moveData.EXTRA_JUMPS #Sets double jumps when the game starts
	Events.connect("player_hurt", Callable(self , "_on_player_hurt"))
	
func _on_player_hurt():
	life -= 1
	if life == 0:
		player_death()

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# Changes how to player acts based on its state
	match state:
		MOVE: move_state(direction, delta)
		CLIMB: climb_state(direction)

# Checks whether the player is on a ladder
func is_on_ladder():
	var collider = ladder_check.get_collider()
	if not ladder_check.is_colliding(): return false
	if not collider is Ladder: return false
	return true

# Controls the move state
func move_state(direction, delta):
	# Checks to see if you are on a ladder
	if is_on_ladder() and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")):
		state = CLIMB # Puts you into climb mode
		
	# Adds the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump/ buffered jump.
	if (Input.is_action_pressed("ui_accept") and is_on_floor() ) or (jump_buffer and is_on_floor()):
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = moveData.JUMP_VELOCITY
		was_in_air = true
		jump_buffer = false
	# Handle double jump
	if Input.is_action_just_pressed("ui_accept") and double_jump > 0 and not is_on_floor():
		SoundPlayer.play_sound(SoundPlayer.JUMP)
		velocity.y = moveData.JUMP_VELOCITY
		double_jump -= 1
	# Turns on buffered jump and timeout timer
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer = true
		jump_timer.start()
		
	# Flips the sprite to face the correct movement direction
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
		
	# Controls acceleration and deceleration
	if direction.x:
		velocity.x = move_toward(velocity.x,direction.x * moveData.SPEED, moveData.ACCELERATION)
	elif not direction.x and not is_on_floor():
		velocity.x = move_toward(velocity.x,direction.x * moveData.SPEED, moveData.ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, moveData.FRICTION)
	
	# Controls sprites and animation
	if is_on_floor() and direction.x:
		sprite.play("run")
	elif is_on_floor() and not direction.x:
		sprite.play("idle")
	elif not is_on_floor():
		sprite.play("jump")
	
	# Controls variables that need to change on landing
	if is_on_floor() and was_in_air:
		sprite.play("idle")
		was_in_air = false
		double_jump = moveData.EXTRA_JUMPS
	move_and_slide()

# Controls the climb state
func climb_state(direction):
	if not is_on_ladder():
		state = MOVE
	sprite.play("idle")
	velocity = direction * moveData.CLIMB_SPEED # controls the speed you move at while on a 
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
	move_and_slide()

# Turns off the jump buffer after a small timeout period
func _on_jump_buffer_timeout():
	jump_buffer = false

#Controls Player getting hurt
func player_hurt():
	SoundPlayer.play_sound(SoundPlayer.HURT) #Plays hurt sound
	Events.emit_signal("player_hurt") # Emits hurt signal

# Controls Player death
func player_death():
	#On Death it plays a sound, deletes the character instance, and emits
	SoundPlayer.play_sound(SoundPlayer.LOSE)
	queue_free()
	Events.emit_signal("player_died")
	
#Forces the camera to follow the player
func connect_camera(camera):
	var camera_path = camera.get_path()
	remote_trans.remote_path = camera_path
	
func bounce():
	velocity.y = moveData.JUMP_VELOCITY
	was_in_air = true
