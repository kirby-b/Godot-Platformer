extends Node2D

# States of falling and rising
enum{
	CRUSH,
	RISE,
	IDLE,
	LAND
}
# Initial State
var state = IDLE

var player_in_radius = false

# Onready for loading nodes
@onready var start_pos = global_position
@onready var timer = $Timer
@onready var detect_floor = $RayCast2D
@onready var sprite = $AnimatedSprite2D
@onready var particles = $GPUParticles2D

func _ready():
	particles.one_shot = true # Makes the particles play once per landing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state: # Calls a function based on state
		CRUSH: crush(delta)
		RISE: rise(delta)
		IDLE: idle()
		LAND: land()
	
# Controls idle before fall
func idle():
	sprite.play("idle") # Idle animation
	if timer.time_left == 0: # Waits and sets state to crush
		state = CRUSH

# Controls crush
func crush(delta):
	sprite.play("crush") # Plays angry crush face
	if detect_floor.is_colliding() == false:
		position.y += 200 * delta # Falls until it hits the ground
	else:
		# When it hits, it emits particles, plays a boom, and sets the state
		particles.emitting = true
		if player_in_radius == true:
			SoundPlayer.play_sound(SoundPlayer.BOOM)
		state = LAND
		timer.start(1) # Starts timer
	
# Controls rise
func rise(delta):
	particles.emitting = false # Ends particles
	sprite.play("idle") # Idle animation because he shouldnt look mad going up
	position.y = move_toward(position.y, start_pos.y, 50 * delta) #Goes up
	if position.y == start_pos.y:
		state = IDLE # Becomes idle
		timer.start(2) # Starts timer

# Controls idle before rise
func land():
	sprite.play("idle") # Idle animation
	if timer.time_left == 0: # Waits and sets state to rise
		state = RISE


func _on_sound_radius_body_entered(body):
	if body is Player:
		player_in_radius = true
	# When the doors area is entered by a player it sets touching as true


func _on_sound_radius_body_exited(body):
	if body is Player:
		player_in_radius = false
	# When the doors area is exited by a player it sets touching as true
