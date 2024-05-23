extends CharacterBody2D
class_name Player

# States for whether you are climbing or on the ground
enum{
	MOVE,
	CLIMB
}

# Gets movement data variables
@export() var moveData: Resource = load("res://Resources/BaseMovement.tres")
# Gets the bullet scene for instancing
@export var Bullet : PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Initial Variables
var state = MOVE
var double_jump = 0 
var was_in_air = false # Tracks whether the player was just in the air
var jump_buffer = false # Tracks whether the jump buffer is on
var can_fire = true
var life = 6
var aim_direction = 1

# On ready variables to access nodes 
@onready var sprite = $AnimatedSprite2D
@onready var bounce_check_1 = $BounceChecker
@onready var bounce_check_2 = $BounceChecker2
@onready var ladder_check = $LadderChecker
@onready var jump_timer = $Timers/JumpBuffer
@onready var bullet_delay = $Timers/BulletDelay
@onready var muzzle_flash = $Timers/MuzzleFlash
@onready var remote_trans = $RemoteTransform2D
@onready var gun = $Gun
@onready var flash = $Gun/Bang
@onready var muzzle = $Gun/Muzzle
@onready var sinktime = $Timers/SinkTimer

func _ready():
	sprite.sprite_frames = load("res://Resources/playerblue.tres")
	double_jump = moveData.EXTRA_JUMPS # Sets double jumps when the game starts
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
	# Determines if the gun is active
	if GlobalVars.has_gun == false: 
		gun.hide()
	elif GlobalVars.has_gun == true:
		gun.show()
		flash.hide()
	if Input.is_action_just_pressed("Test_Button"):
		sink()
	# Fires gun
	if Input.is_action_just_pressed("shoot") and GlobalVars.has_gun == true and can_fire == true and GlobalVars.ammo > 0:
		shoot()
		
	# Checks to see if you are on a ladder
	if is_on_ladder() and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")):
		state = CLIMB # Puts you into climb mode
		
	# Adds the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Makes it so the player can fall through one way platforms
	if (Input.is_action_just_pressed("ui_down") and is_on_floor()):
		position.y += 1
	
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
		
	# Flips the sprite to face the correct movement direction and contolling
	# where the gun faces
	if direction.x > 0:
		sprite.flip_h = true
		gun.flip_h = false
		gun.offset = Vector2(10, 0)
		flash.flip_h = false
		flash.offset = Vector2(22, 0)
		muzzle.position = Vector2(17, -1)
		aim_direction = 1
	elif direction.x < 0:
		sprite.flip_h = false
		gun.flip_h = true
		gun.offset = Vector2(-10, 0)
		flash.flip_h = true
		flash.offset = Vector2(-22, 0)
		muzzle.position = Vector2(-17, -1)
		aim_direction = -1
		
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
	velocity = direction * moveData.CLIMB_SPEED # controls ladder speed
	
	# Determines if the gun is active
	if GlobalVars.has_gun == false: 
		gun.hide()
	elif GlobalVars.has_gun == true:
		gun.show()
	
	# Fires gun
	if Input.is_action_just_pressed("shoot") and GlobalVars.has_gun == true:
		shoot()
		
	# Flips the sprite to face the correct movement direction and contolling
	# where the gun faces
	if direction.x > 0:
		sprite.flip_h = true
		gun.flip_h = false
		gun.offset = Vector2(10, 0)
		flash.flip_h = false
		flash.offset = Vector2(22, 0)
		muzzle.position = Vector2(17, -1)
		aim_direction = 1
	elif direction.x < 0:
		sprite.flip_h = false
		gun.flip_h = true
		gun.offset = Vector2(-10, 0)
		flash.flip_h = true
		flash.offset = Vector2(-22, 0)
		muzzle.position = Vector2(-17, -1)
		aim_direction = -1
	move_and_slide()

# Turns off the jump buffer after a small timeout period
func _on_jump_buffer_timeout():
	jump_buffer = false

# Controls Player getting hurt
func player_hurt():
	SoundPlayer.play_sound(SoundPlayer.HURT) #Plays hurt sound
	Events.emit_signal("player_hurt") # Emits hurt signal

# Controls Player death
func player_death():
	# On Death it plays a sound, deletes the character instance, and emits
	SoundPlayer.play_sound(SoundPlayer.LOSE)
	queue_free()
	Events.emit_signal("player_died")
	
# Forces the camera to follow the player
func connect_camera(camera):
	var camera_path = camera.get_path()
	remote_trans.remote_path = camera_path
	
# Makes it so the player bounces into the air if something tells it to
func bounce():
	velocity.y = moveData.JUMP_VELOCITY
	was_in_air = true

# Makes the gun shoot
func shoot():
	var b = Bullet.instantiate()
	b.aim(aim_direction)
	get_tree().current_scene.add_child(b)
	b.transform = muzzle.global_transform
	SoundPlayer.play_sound(SoundPlayer.BANG)
	GlobalVars.ammo -= 1
	flash.show()
	muzzle_flash.start()
	can_fire = false
	bullet_delay.start()

# Waits so you cant bullet spam
func _on_bullet_delay_timeout():
	can_fire = true

# Hides flash on timeout
func _on_muzzle_flash_timeout():
	flash.hide()
	
func sink():
	for n in 25:
		sprite.offset = Vector2(0, 1+n)
		sinktime.start()
		await sinktime.timeout
	Events.emit_signal("sink_finish")

func unsink():
	sprite.offset = Vector2(0,0)
		
