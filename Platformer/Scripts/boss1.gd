extends CharacterBody2D

@onready var lazer_delay = $LazerDelay
@onready var fire_point = $LazerSpawn
@onready var sprite = $AnimatedSprite2D
var can_fire = true

# Gets the lazer scene for instancing
@export var Lazer : PackedScene
@export() var speed: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var aim_direction = 1
var direction = 1

func _physics_process(delta):
	if GlobalVars.activeboss == true:
		for n in 4:
			shoot()
			await can_fire
			aim_direction *= -1
		#Set boss position to random tube point
	# Adds the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Detects if they hit a wall
	var found_wall = is_on_wall() 
	
	# Changes direction if they find a wall of ledge
	if found_wall:
		direction *= -1
	# Gets the flip with a simple boolean
	sprite.flip_h = direction > 0
	
	sprite.play("walk") # Constantly plays the walk
	velocity.x = direction * speed # Constant speed
	move_and_slide()

# Makes the gun shoot
func shoot():
	var l = Lazer.instantiate()
	l.aim(aim_direction)
	get_tree().current_scene.add_child(l)
	l.transform = fire_point.global_transform
	SoundPlayer.play_sound(SoundPlayer.BANG)
	can_fire = false
	lazer_delay.start()

func _on_lazer_delay_timeout():
	can_fire = true
